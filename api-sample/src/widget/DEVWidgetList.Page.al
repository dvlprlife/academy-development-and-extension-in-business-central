namespace SummitNA.API.Widget;

page 50201 "DEV Widget List"
{
    ApplicationArea = All;
    Caption = 'Widget List';
    PageType = List;
    SourceTable = "DEV Widget";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Random; Rec.Random)
                {
                    Editable = false;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
            }
        }
    }
}
