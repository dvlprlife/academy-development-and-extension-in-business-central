namespace SummitNA.API.Stock;

page 50204 "DEV API Dialog"
{
    ApplicationArea = All;
    Caption = 'API Dialog';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field(Password; PasswordValue)
            {
                ApplicationArea = All;
                Caption = 'Password';
                ExtendedDatatype = Masked;
                ToolTip = 'Specifies the password for this task.';

                trigger OnValidate()
                var
                    StorageManagement: Codeunit "DEV Storage Management";
                begin
                    StorageManagement.SetAPIKey(PasswordValue);
                end;
            }
        }
    }
    var
        [NonDebuggable]
        PasswordValue: Text;
}