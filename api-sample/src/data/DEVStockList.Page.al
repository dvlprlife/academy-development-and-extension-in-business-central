namespace SummitNA.API.Stock;

page 50203 "DEV Stock List"
{
    ApplicationArea = All;
    Caption = 'Stocks List';
    PageType = List;
    SourceTable = "DEV Stock";
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Symbol; Rec.Symbol)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
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
            action(DEVStock)
            {
                ApplicationArea = All;
                Caption = 'Manage Data';
                Image = Card;
                ToolTip = 'Monitor stock time series information.';
                RunObject = page "DEV Time Series Data List";
            }

            action(SaveAPIKey)
            {
                ApplicationArea = All;
                Caption = 'Save API Key';
                Image = Save;

                trigger OnAction()
                var

                    APIDialog: Page "DEV API Dialog";
                begin
                    APIDialog.RunModal();
                end;
            }

        }
    }
}
