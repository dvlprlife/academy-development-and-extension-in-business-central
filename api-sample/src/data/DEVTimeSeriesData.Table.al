namespace SummitNA.API.Stock;

table 50201 "DEV Time Series Data"
{
    Caption = 'Time Series Data';
    DataClassification = CustomerContent;
    TableType = Temporary;
    Description = 'Table to hold time series data for various analyses and visualizations.';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            BlankZero = false;
            Caption = 'Entry No.';
            NotBlank = true;
            ToolTip = 'Specifies the unique entry number for the time series data record.';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the date for the stock price data.';
        }
        field(3; Open; Decimal)
        {
            BlankZero = true;
            Caption = 'Open';
            ToolTip = 'Specifies the opening stock price for the trading period.';
        }
        field(4; High; Decimal)
        {
            BlankZero = true;
            Caption = 'High';
            ToolTip = 'Specifies the highest stock price reached during the trading period.';
        }
        field(5; Low; Decimal)
        {
            BlankZero = true;
            Caption = 'Low';
            ToolTip = 'Specifies the lowest stock price reached during the trading period.';
        }
        field(6; Close; Decimal)
        {
            BlankZero = true;
            Caption = 'Close';
            ToolTip = 'Specifies the closing stock price for the trading period.';
        }
        field(7; Volume; Integer)
        {
            BlankZero = true;
            Caption = 'Volume';
            ToolTip = 'Specifies the number of shares traded during the trading period.';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
