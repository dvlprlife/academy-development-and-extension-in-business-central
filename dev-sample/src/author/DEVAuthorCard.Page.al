page 50101 "DEV Author Card"
{
    ApplicationArea = All;
    Caption = 'Author Card';
    PageType = Card;
    SourceTable = "DEV Author";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
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
                field("Social Security No."; Rec."Social Security No.")
                {
                    ToolTip = 'Specifies the value of the Social Security No. field.';
                }
            }
            group(Address)
            {
                Caption = 'Address';
                field(Address1; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
            }
        }

        area(FactBoxes)
        {
            part(Control149; "DEV Author Factbox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("No.");
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(BookRef; Book) { }
        }
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
