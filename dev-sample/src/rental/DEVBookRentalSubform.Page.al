page 50106 "DEV Book Rental Subform"
{
    ApplicationArea = All;
    Caption = 'Rental Lines';
    PageType = ListPart;
    SourceTable = "DEV Book Rental Line";
    DelayedInsert = true;
    LinksAllowed = false;
    AutoSplitKey = true;

    layout
    {
        area(content)
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
