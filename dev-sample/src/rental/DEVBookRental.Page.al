namespace SummitNA.BookManagement.Rental;
page 50105 "DEV Book Rental"
{
    ApplicationArea = All;
    Caption = 'Book Rental';
    PageType = Card;
    SourceTable = "DEV Book Rental Header";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.") { }
                field(ContractDate; Rec."Contract Date") { }
                field(ReturnDate; Rec."Return Date") { }
                field(Description; Rec.Description) { }
                field(Status; Rec.Status) { }
            }
            group(Contact)
            {
                field(ContactNo; Rec."Contact No.") { }
                field(ContactName; Rec."Contact Name") { }
            }

            part(RentalLines; "DEV Book Rental Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Rental Header No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CheckRentalLines)
            {
                Caption = 'Check Rental Lines';
                Image = Check;
                ToolTip = 'Check Rental Lines';

                trigger OnAction()
                var
                    RentalManagement: Codeunit "DEV Rental Management";
                begin
                    RentalManagement.Run(Rec);
                end;
            }
        }
    }
}
