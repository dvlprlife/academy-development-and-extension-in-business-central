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
        }
        field(5; Title; Text[50])
        {
            Caption = 'Title';
        }
        field(10; "Short Description"; Text[50])
        {
            Caption = 'Short Description';
        }
        field(12; Description; Blob)
        {
            Caption = 'Description';
            Subtype = Memo;
        }
        field(20; "Book Type"; Enum "DEV Book Type")
        {
            Caption = 'Type';
        }
        field(25; Status; Enum "DEV Book Status")
        {
            Caption = 'Status';

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
}
