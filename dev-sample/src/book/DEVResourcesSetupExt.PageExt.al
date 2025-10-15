namespace SummitNA.BookManagement.Book;

using Microsoft.Projects.Resources.Setup;

pageextension 50101 "DEV Resources Setup Ext" extends "Resources Setup"
{
    layout
    {
        addafter(Numbering)
        {
            group(DEVRental)
            {
                Caption = 'Rental';
                field(DEVAuthorNos; Rec."DEV Author Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(DEVBookNos; Rec."DEV Book Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(DEVRentalNos; Rec."DEV Rental Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}
