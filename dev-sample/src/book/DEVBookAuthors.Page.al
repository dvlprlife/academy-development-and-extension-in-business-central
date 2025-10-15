namespace SummitNA.BookManagement.Book;

using SummitNA.BookManagement.Author;

page 50104 "DEV Book Authors"
{
    ApplicationArea = All;
    Caption = 'Book Authors';
    PageType = List;
    SourceTable = "DEV Book Author";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(AuthorNo; Rec."Author No.")
                {
                }
                field(AuthorLastName; Rec."Author Last Name")
                {
                }
                field(AuthorName; FullName)
                {
                    Caption = 'Full Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Author Name field.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Author: Record "DEV Author";
    begin
        FullName := Author.GetAuthorName(Rec."Author No.");
    end;

    var
        FullName: Text[100];
}
