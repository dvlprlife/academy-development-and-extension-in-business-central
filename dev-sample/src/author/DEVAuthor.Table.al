table 50100 "DEV Author"
{
    Caption = 'Author';
    DataCaptionFields = "No.", "Last Name", "First Name";
    DataClassification = CustomerContent;
    DrillDownPageId = "DEV Author List";
    LookupPageId = "DEV Author List";

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
        field(5; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(10; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
        }
        field(15; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(25; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(30; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(35; City; Text[30])
        {
            Caption = 'City';
        }
        field(40; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
        field(45; County; Text[30])
        {
            Caption = 'County';
        }
        field(50; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(55; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
#pragma warning disable AA0139
                MailManagement.ValidateEmailAddressField("E-Mail");
#pragma warning restore
            end;
        }
        field(60; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
            DataClassification = EndUserIdentifiableInformation;
            ExtendedDatatype = Masked;
        }
        field(70; Status; Enum "DEV Author Status")
        {
            Caption = 'Status';
        }
        field(75; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(80; "No. Books"; Integer)
        {
            CalcFormula = count("DEV Book Author" where("Author No." = field("No.")));
            Caption = 'No. Books';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "First Name", "Last Name") { }
        fieldgroup(Brick; "Last Name", "First Name", Status) { }
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
    begin
        Rec.CalcFields("No. Books");
        Rec.TestField("No. Books", 0);
    end;

    var
        ResourcesSetup: Record "Resources Setup";
        NoSeries: Codeunit "No. Series";
        SetupRead: Boolean;

    procedure GetAuthorName(No: Code[20]) FullName: Text[100]
    var
        Author: Record "DEV Author";
        AuthorNameTxt: Label '%1 %2', Comment = '%1 First Name, %2 Last Name';
    begin
        if Author.Get(No) then begin
            FullName := StrSubstNo(AuthorNameTxt, Author."First Name", Author."Last Name");
            FullName := CopyStr(FullName.Trim(), 1, MaxStrLen(FullName));
        end;
    end;

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

        ResourcesSetup.TestField("DEV Author Nos.");
        NoSeriesCode := ResourcesSetup."DEV Author Nos.";

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
        Author: Record "DEV Author";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeTestNoSeries(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        if "No." <> xRec."No." then
            if not Author.Get(Rec."No.") then begin
                GetSetup();
                NoSeries.TestManual(GetNoSeriesCode());
                "No. Series" := '';
            end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetNoSeriesCode(var Author: Record "DEV Author"; ResourcesSetup: Record "Resources Setup"; var NoSeriesCode: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetNoSeriesCode(var Author: Record "DEV Author"; ResourcesSetup: Record "Resources Setup"; var NoSeriesCode: Code[20]; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsert(var Author: Record "DEV Author"; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTestNoSeries(var Author: Record "DEV Author"; xAuthor: Record "DEV Author"; var Handled: Boolean)
    begin
    end;
}
