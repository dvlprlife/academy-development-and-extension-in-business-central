page 50107 "DEV Author Factbox"
{
    ApplicationArea = All;
    Caption = 'Author Factbox';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "DEV Author";

    layout
    {
        area(Content)
        {
            field(NoBooks; Rec."No. Books")
            {
                ShowCaption = true;
                ToolTip = 'Specifies the number of books an author wrote.';
            }
        }
    }
}
