namespace SummitNA.BookManagement.Author;

using SummitNA.BookManagement.Book;
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
                }
                field(Status; Rec.Status)
                {
                }
                field(FirstName; Rec."First Name")
                {
                }
                field(MiddleName; Rec."Middle Name")
                {
                }
                field(LastName; Rec."Last Name")
                {
                }
                field(SocialSecurityNo; Rec."Social Security No.")
                {
                }
                field(AuthorType; Rec."Author Type")
                {
                }
                field(Rating; Rec.Rating)
                {
                }
            }
            group(Address)
            {
                Caption = 'Address';
                field(Address1; Rec.Address)
                {
                }
                field(Address2; Rec."Address 2")
                {
                }
                field(City; Rec.City)
                {
                }
                field(County; Rec.County)
                {
                }
                field(PostCode; Rec."Post Code")
                {
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field(PhoneNo; Rec."Phone No.")
                {
                }
                field(Email; Rec."E-Mail")
                {
                }
            }
        }

        area(FactBoxes)
        {
            part(Control149; "DEV Author FactBox")
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
