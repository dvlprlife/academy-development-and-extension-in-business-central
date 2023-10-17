page 50105 "DEV Book Rental"
{
    ApplicationArea = All;
    Caption = 'Book Rental';
    PageType = Card;
    SourceTable = "DEV Book Rental Header";
    UsageCategory = None;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the status field.';
                }
            }
            group(Contact)
            {
                field("Contact No."; Rec."Contact No.")
                {
                    ToolTip = 'Specifies the value of the Contact No. field.';
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ToolTip = 'Specifies the value of the Contact Name field.';
                }
            }

            part(Rentalines; "DEV Book Rental Subform")
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
                ApplicationArea = All;
                Caption = 'Check Rental Lines';
                ToolTip = 'Check Rental Lines';
                Image = Check;

                trigger OnAction()
                var
                    RentalManagment: Codeunit "DEV Rental Managment";
                begin
                    RentalManagment.Run(Rec);
                end;
            }
        }
    }
}
