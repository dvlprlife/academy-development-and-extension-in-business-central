table 50200 "DEV Widget"
{
    Caption = 'Widget';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the value of the No. field.';
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the value of the Description field.';
        }
        field(10; Random; Integer)
        {
            Caption = 'Random';
            ToolTip = 'Specifies the value of the Random field.';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
