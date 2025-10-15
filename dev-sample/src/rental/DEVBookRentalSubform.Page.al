namespace SummitNA.BookManagement.Rental;
page 50106 "DEV Book Rental Subform"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Rental Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "DEV Book Rental Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(BookNo; Rec."Book No.")
                {
                }
                field(BookTitle; Rec."Book Title")
                {
                }
            }
        }
    }
}
