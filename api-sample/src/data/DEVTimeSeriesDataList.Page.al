namespace SummitNA.API.Stock;

using Microsoft.Inventory.Availability;

page 50202 "DEV Time Series Data List"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Time Series Data List';
    PageType = List;
    SourceTable = "DEV Time Series Data";
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Symbol; Symbol)
                {
                    ApplicationArea = Basic, Suite;
                    TableRelation = "DEV Stock".Symbol;
                    ToolTip = 'Specifies the stock symbol associated with the time series data.';
                }
                field("Time Series Type"; TimeSeries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Time Series';
                    ToolTip = 'Specifies the type of time series data (Daily, Weekly, Monthly).';
                }
            }
            repeater(control1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(High; Rec.High)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Low; Rec.Low)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Close; Rec.Close)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = Basic, Suite;
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
                    StockManagement: Codeunit "DEV Stock Management";
                    MetaDictionary: Dictionary of [Text, Text];
                    TimeSeriesData: Record "DEV Time Series Data" temporary;
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
