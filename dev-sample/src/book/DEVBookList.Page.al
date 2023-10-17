page 50103 "DEV Book List"
{
    ApplicationArea = All;
    Caption = 'Book List';
    PageType = List;
    SourceTable = "DEV Book";
    UsageCategory = Lists;
    CardPageId = "DEV Book Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field("Book Type"; Rec."Book Type")
                {
                    ToolTip = 'Specifies the value of the Book Type field.';
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
