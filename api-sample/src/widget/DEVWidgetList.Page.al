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
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Random; Rec.Random)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Random field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
            }
        }
    }
}
