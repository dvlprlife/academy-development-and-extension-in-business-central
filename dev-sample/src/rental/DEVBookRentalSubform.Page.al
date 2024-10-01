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
                field("Book No."; Rec."Book No.")
                {
                    ToolTip = 'Specifies the value of the Contact No. field.';
                }
                field("Book Title"; Rec."Book Title")
                {
                    ToolTip = 'Specifies the value of the Book Title field.';
                }
            }
        }
    }
}
