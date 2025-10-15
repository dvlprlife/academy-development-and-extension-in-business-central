namespace SummitNA.API.Stock;

enum 50200 "DEV Time Series"
{
    Extensible = true;

    value(0; TIME_SERIES_DAILY)
    {
        Caption = 'Daily';
    }
    value(1; TIME_SERIES_WEEKLY)
    {
        Caption = 'Weekly';
    }
    value(2; TIME_SERIES_MONTHLY)
    {
        Caption = 'Monthly';
    }
}
