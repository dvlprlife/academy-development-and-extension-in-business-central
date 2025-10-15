namespace SummitNA.API.Management;

using Microsoft.Finance.RoleCenters;
using SummitNA.API.Widget;
using SummitNA.API.Stock;

pageextension 50200 "DEV API Role Center Ext" extends "Business Manager Role Center"
{
    actions
    {
        addfirst(sections)
        {
            group(DEVAPI)
            {
                Caption = 'API';
                Image = Administration;

                action(DEVWidget)
                {
                    ApplicationArea = All;
                    Caption = 'Manage Widgets';
                    Image = Card;
                    ToolTip = 'Access your complete widget catalog. Add new or edit widget details.';
                    RunObject = page "DEV Widget List";
                }
                action(DEVStock)
                {
                    ApplicationArea = All;
                    Caption = 'Manage Stocks';
                    Image = Card;
                    ToolTip = 'Monitor and manage stock information. Create new or edit stock entries.';
                    RunObject = page "DEV Stock List";
                }
            }
        }
    }
}
