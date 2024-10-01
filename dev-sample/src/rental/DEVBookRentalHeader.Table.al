table 50103 "DEV Book Rental Header"
{
    Caption = 'Book Rental Header';
    DataClassification = CustomerContent;
    DrillDownPageId = "DEV Book Rental List";
    LookupPageId = "DEV Book Rental List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                TestNoSeries();
            end;
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(10; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact."No." where(Type = const("Contact Type"::Person));
        }
        field(20; "Contact Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field("Contact No.")));
            Caption = 'Contact Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(35; Status; Enum "DEV Rental Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(900; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = SystemMetadata;
            Editable = false;
            TableRelation = "No. Series".Code;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(key1; Date, "Contact No.") { }
    }

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeInsert(Rec, IsHandled);
        if IsHandled then
            exit;

        if ("No." = '') then begin
            "No. Series" := GetNoSeriesCode();
            if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series", WorkDate());
        end;
    end;

    trigger OnDelete()
    var
        BookRentalLine: Record "DEV Book Rental Line";
    begin
        BookRentalLine.SetRange("Rental Header No.", "No.");
        BookRentalLine.DeleteAll();
    end;

    var
        ResourcesSetup: Record "Resources Setup";
        NoSeries: Codeunit "No. Series";
        SetupRead: Boolean;

    local procedure GetNoSeriesCode(): Code[20]
    var
        IsHandled: Boolean;
        NoSeriesCode: Code[20];
    begin
        GetSetup();
        IsHandled := false;
        OnBeforeGetNoSeriesCode(Rec, ResourcesSetup, NoSeriesCode, IsHandled);
        if IsHandled then
            exit(NoSeriesCode);

        ResourcesSetup.TestField("DEV Rental Nos.");
        NoSeriesCode := ResourcesSetup."DEV Rental Nos.";

        OnAfterGetNoSeriesCode(Rec, ResourcesSetup, NoSeriesCode);

        if NoSeries.IsAutomatic(NoSeriesCode) then
            exit(NoSeriesCode);

        if NoSeries.HasRelatedSeries(NoSeriesCode) then
            if NoSeries.LookupRelatedNoSeries(NoSeriesCode, "No. Series") then
                exit("No. Series");

        exit(NoSeriesCode);
    end;

    local procedure GetSetup()
    begin
        if SetupRead then
            exit;

        ResourcesSetup.Get();
        SetupRead := true;
    end;

    local procedure TestNoSeries()
    var
        BookRentalHeader: Record "DEV Book Rental Header";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeTestNoSeries(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        if "No." <> xRec."No." then
            if not BookRentalHeader.Get(Rec."No.") then begin
                GetSetup();
                NoSeries.TestManual(GetNoSeriesCode());
                "No. Series" := '';
            end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetNoSeriesCode(var BookRentalHeader: Record "DEV Book Rental Header"; ResourcesSetup: Record "Resources Setup"; var NoSeriesCode: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetNoSeriesCode(var BookRentalHeader: Record "DEV Book Rental Header"; ResourcesSetup: Record "Resources Setup"; var NoSeriesCode: Code[20]; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsert(var BookRentalHeader: Record "DEV Book Rental Header"; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTestNoSeries(var BookRentalHeader: Record "DEV Book Rental Header"; xBookRentalHeader: Record "DEV Book Rental Header"; var Handled: Boolean)
    begin
    end;
}
