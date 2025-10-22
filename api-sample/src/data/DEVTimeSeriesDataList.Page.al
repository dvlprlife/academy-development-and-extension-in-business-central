namespace SummitNA.API.Stock;

page 50202 "DEV Time Series Data List"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Time Series Data List';
    Editable = true;
    PageType = List;
    SourceTable = "DEV Time Series Data";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Symbol; Symbol)
                {
                    TableRelation = "DEV Stock".Symbol;
                    ToolTip = 'Specifies the stock symbol associated with the time series data.';
                }
                field("Time Series Type"; TimeSeries)
                {
                    Caption = 'Time Series';
                    ToolTip = 'Specifies the type of time series data (Daily, Weekly, Monthly).';
                }
            }
            repeater(control1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field("Date"; Rec."Date")
                {
                }
                field(Open; Rec.Open)
                {
                }
                field(High; Rec.High)
                {
                }
                field(Low; Rec.Low)
                {
                }
                field(Close; Rec.Close)
                {
                }
                field(Volume; Rec.Volume)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(LoadData)
            {
                ApplicationArea = All;
                Caption = 'Load Data';
                Image = Refresh;
                ToolTip = 'Load time series data for the selected stock symbol and time series type.';

                trigger OnAction()
                var
                    TimeSeriesData: Record "DEV Time Series Data" temporary;
                    StockManagement: Codeunit "DEV Stock Management";
                    MetaDictionary: Dictionary of [Text, Text];
                begin

                    // Clear existing data
                    Rec.DeleteAll();

                    // Retrieve stock price data
                    StockManagement.RetrieveStockPrice(Symbol, TimeSeries, MetaDictionary, TimeSeriesData);

                    // Copy data from temporary record to the page's source table
                    if TimeSeriesData.FindSet() then
                        repeat
                            Rec := TimeSeriesData;
                            Rec.Insert();
                        until TimeSeriesData.Next() = 0;

                    // Refresh the page to show the loaded data
                    Rec.FindFirst();
                    CurrPage.Update();
                end;
            }
        }
    }

    var
        Symbol: Code[10];
        TimeSeries: Enum "DEV Time Series";
}
