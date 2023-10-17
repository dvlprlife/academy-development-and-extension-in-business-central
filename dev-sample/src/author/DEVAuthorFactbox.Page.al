page 50107 "DEV Author Factbox"
{
    Caption = 'Author Factbox';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "DEV Author";

    layout
    {
        area(content)
        {
            field(NoBooks; Rec."No. Books")
            {
                ApplicationArea = All;
                ShowCaption = true;
                ToolTip = 'Specifies the number of books an author wrote.';
            }
        }
    }
}

