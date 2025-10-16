namespace SummitNA.BookManagement.Author;

table 50105 "DEV Author Type"
{
    Caption = 'Author Type';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the code for the author type.';
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the author type.';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
