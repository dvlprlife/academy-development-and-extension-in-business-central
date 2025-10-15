namespace SummitNA.BookManagement.Book;

page 50103 "DEV Book List"
{
    ApplicationArea = All;
    Caption = 'Book List';
    CardPageId = "DEV Book Card";
    PageType = List;
    SourceTable = "DEV Book";
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
                field(Title; Rec.Title)
                {
                }
                field(BookType; Rec."Book Type")
                {
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Authors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Authors';
                Image = Resource;
                RunObject = page "DEV Book Authors";
                RunPageLink = "Book No." = field("No.");
                ToolTip = 'View or edit the authors for this book.';
            }
        }
    }
}
