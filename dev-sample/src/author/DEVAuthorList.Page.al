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
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
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
                ToolTip = 'View orthe books for this book.';

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
