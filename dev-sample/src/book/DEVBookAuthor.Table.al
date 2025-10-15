namespace SummitNA.BookManagement.Book;

using SummitNA.BookManagement.Author;

table 50102 "DEV Book Author"
{
    Caption = 'Book Author';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Book No."; Code[20])
        {
            Caption = 'Book No.';
            TableRelation = "DEV Book"."No.";
            ToolTip = 'Specifies the value of the Book No. field.';
        }
        field(5; "Author No."; Code[20])
        {
            Caption = 'Author No.';
            TableRelation = "DEV Author"."No.";
            ToolTip = 'Specifies the value of the Author No. field.';
        }
        field(10; "Author Last Name"; Text[30])
        {
            CalcFormula = lookup("DEV Author"."Last Name" where("No." = field("Author No.")));
            Caption = 'Author Name';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies the value of the Author Name field.';
        }
    }

    keys
    {
        key(PK; "Book No.", "Author No.")
        {
            Clustered = true;
        }
    }
}
