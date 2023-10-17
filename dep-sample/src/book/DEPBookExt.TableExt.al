tableextension 50120 "DEP Book Ext" extends "DEV Book"
{
    fields
    {
        field(50120; "DEP Year"; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(50121; "DEP Price"; Decimal)
        {
            Caption = 'Price';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
    }
}
