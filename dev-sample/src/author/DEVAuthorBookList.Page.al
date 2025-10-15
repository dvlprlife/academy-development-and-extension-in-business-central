namespace SummitNA.BookManagement.Author;

using SummitNA.BookManagement.Book;

page 50109 "DEV Author Book List"
{
    ApplicationArea = All;
    Caption = 'Author Book List';
    Editable = false;
    PageType = List;
    SourceTable = "DEV Book Author";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Book  No."; Rec."Book No.")
                {
                }
                field("Book Title"; BookTitle)
                {
                    Caption = 'Book Title';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Book Title field.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Book: Record "DEV Book";
    begin
        Book.Get(Rec."Book No.");
        BookTitle := Book.Title;
    end;

    var
        BookTitle: Text[100];
}
