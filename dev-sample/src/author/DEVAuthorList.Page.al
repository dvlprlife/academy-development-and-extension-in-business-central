namespace SummitNA.BookManagement.Author;

using SummitNA.BookManagement.Book;
page 50100 "DEV Author List"
{
    ApplicationArea = All;
    Caption = 'Author List';
    CardPageId = "DEV Author Card";
    Editable = false;
    PageType = List;
    SourceTable = "DEV Author";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Book)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Books';
                Image = Card;
                ToolTip = 'View of the books for this author.';

                trigger OnAction()
                var
                    BookAuthor: Record "DEV Book Author";
                begin
                    BookAuthor.SetRange("Author No.", Rec."No.");
                    Page.Run(Page::"DEV Author Book List", BookAuthor);
                end;
            }
        }
    }
}
