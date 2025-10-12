namespace SummitNA.BookManagement.Book;

using Microsoft.Foundation.NoSeries;
using Microsoft.Projects.Resources.Setup;
using SummitNA.BookManagement.Rental;

table 50101 "DEV Book"
{
    Caption = 'Book';
    DataClassification = CustomerContent;
    DrillDownPageId = "DEV Book List";
    LookupPageId = "DEV Book List";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            ToolTip = 'Specifies the value of the No. field.';

            trigger OnValidate()
            begin
                TestNoSeries();
            end;
        }
        field(5; Title; Text[50])
        {
            Caption = 'Title';
            ToolTip = 'Specifies the value of the Title field.';
        }
        field(10; "Short Description"; Text[50])
        {
            Caption = 'Short Description';
            ToolTip = 'Specifies the value of the Description field.';
        }
        field(12; Description; Blob)
        {
            Caption = 'Description';
            Subtype = Memo;
        }
        field(20; "Book Type"; Enum "DEV Book Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the value of the Book Type field.';
        }
        field(25; Status; Enum "DEV Book Status")
        {
            Caption = 'Status';
            ToolTip = 'Specifies the value of the status field.';
            trigger OnValidate()
            var
                BookRentalLine: Record "DEV Book Rental Line";
            begin
                if (Rec.Status <> xRec.Status) and (Rec.Status = "DEV Book Status"::Unavailable) then begin
                    BookRentalLine.SetRange("Book No.", Rec."No.");
                    if not BookRentalLine.IsEmpty then
                        Error('Books exist you can''t change the status to unavailable.');
                end;
            end;
        }
        field(75; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
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
        fieldgroup(DropDown; Title, "Book Type") { }
        fieldgroup(Brick; "No.", Title, Status) { }
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
        BookAuthor: Record "DEV Book Author";
        BookRentalLine: Record "DEV Book Rental Line";
    begin
        BookRentalLine.SetRange("Book No.", "No.");
        if not BookRentalLine.IsEmpty() then
            // ErrorInfo should be used to display the error message
            Error('Book is in use and cannot be deleted.');

        BookAuthor.SetRange("Book No.", "No.");
        BookAuthor.DeleteAll();
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

        ResourcesSetup.TestField("DEV Book Nos.");
        NoSeriesCode := ResourcesSetup."DEV Book Nos.";

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
        Book: Record "DEV Book";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeTestNoSeries(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        if "No." <> xRec."No." then
            if not Book.Get(Rec."No.") then begin
                GetSetup();
                NoSeries.TestManual(GetNoSeriesCode());
                "No. Series" := '';
            end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetNoSeriesCode(var Book: Record "DEV Book"; ResourcesSetup: Record "Resources Setup"; var NoSeriesCode: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetNoSeriesCode(var Book: Record "DEV Book"; ResourcesSetup: Record "Resources Setup"; var NoSeriesCode: Code[20]; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsert(var Book: Record "DEV Book"; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTestNoSeries(var Book: Record "DEV Book"; xBook: Record "DEV Book"; var Handled: Boolean)
    begin
    end;
}
