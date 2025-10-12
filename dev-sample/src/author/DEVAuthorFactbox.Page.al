namespace SummitNA.BookManagement.Author;
page 50107 "DEV Author FactBox"
{
    ApplicationArea = All;
    Caption = 'Author FactBox';
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
            }
        }
    }
}
