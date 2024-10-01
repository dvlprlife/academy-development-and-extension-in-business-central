table 50200 "DEV Widget"
{
    Caption = 'Widget';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; Random; Integer)
        {
            Caption = 'Random';
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
