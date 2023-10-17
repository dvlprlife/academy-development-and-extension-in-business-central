pageextension 50121 "DEP Rental Ext" extends "DEV Book Rental"
{
    actions
    {
        addlast(Processing)
        {
            action(DEPAddNumbers)
            {
                Caption = 'Add Numbers';
                Image = "8ball";
                ToolTip = 'Add Numbers';
                ApplicationArea = All;
                trigger OnAction()
                var
                    NumberManagement: Codeunit "DEP Number Management";
                    answer: Decimal;
                begin
                    answer := NumberManagement.AddNumbers(12, 13);
                    MESSAGE('The answer is %1', format(answer, 0, 1));
                end;
            }
        }
    }
}
