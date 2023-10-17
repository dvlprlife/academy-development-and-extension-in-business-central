table 50103 "DEV Book Rental Header"
{
    Caption = 'Book Rental Header';
    DataClassification = CustomerContent;
    LookupPageId = "DEV Book Rental List";
    DrillDownPageId = "DEV Book Rental List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if (Rec."No." <> xRec."No.") then begin
                    GetSetup();
                    NoSeriesManagement.TestManual(ResourcesSetup."DEV Author Nos.");
                end;
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
            Caption = 'Contact Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("Contact No.")));
            Editable = false;
        }
        field(30; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(35; Status; enum "DEV Rental Status")
        {
            Caption = 'Status';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(key1; Date, "Contact No.")
        {
        }
    }

    var
        ResourcesSetup: Record "Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SetupRead: Boolean;

    trigger OnInsert()
    var
        NewSeriesCode: Code[20];
    begin
        if ("No." = '') then begin
            GetSetup();
            ResourcesSetup.TestField("DEV Rental Nos.");
            NoSeriesManagement.InitSeries(ResourcesSetup."DEV Rental Nos.", '', 0D, "No.", NewSeriesCode);
        end;
    end;

    trigger OnDelete()
    var
        BookRentalLine: Record "DEV Book Rental Line";
    begin
        BookRentalLine.SetRange("Rental Header No.", "No.");
        BookRentalLine.DeleteAll();
    end;

    local procedure GetSetup()
    begin
        if SetupRead then
            exit;

        ResourcesSetup.Get();
        SetupRead := true;
    end;
}
