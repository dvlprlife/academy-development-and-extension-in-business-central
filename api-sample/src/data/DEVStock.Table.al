namespace SummitNA.API.Stock;

table 50202 "DEV Stock"
{
    Caption = 'Stock';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Symbol; Code[10])
        {
            Caption = 'Symbol';
            ToolTip = 'Specifies the stock ticker symbol (e.g., AAPL, MSFT, GOOGL).';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the company name or description for the stock.';
        }
    }
    keys
    {
        key(PK; Symbol)
        {
            Clustered = true;
        }
    }
}
