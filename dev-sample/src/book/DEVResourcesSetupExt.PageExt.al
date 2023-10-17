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
                    ToolTip = 'Specifies the author number series.';
                }
                field(DEVBookNos; Rec."DEV Book Nos.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the book number series.';
                }
                field(DEVRentalNos; Rec."DEV Rental Nos.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the rental number series.';
                }
            }
        }
    }
}
