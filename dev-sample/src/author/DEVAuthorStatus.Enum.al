namespace SummitNA.BookManagement.Author;

enum 50100 "DEV Author Status"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Active)
    {
        Caption = 'Active';
    }
    value(2; Inactive)
    {
        Caption = 'Inactive';
    }
}
