table 50102 "DEV Book Author"
{
    Caption = 'Book Author';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Book No."; Code[20])
        {
            Caption = 'Book No.';
            TableRelation = "DEV Book"."No.";
        }
        field(5; "Author No."; Code[20])
        {
            Caption = 'Author No.';
            TableRelation = "DEV Author"."No.";
        }
        field(10; "Author Last Name"; Text[30])
        {
            CalcFormula = lookup("DEV Author"."Last Name" where("No." = field("Author No.")));
            Caption = 'Author Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(PK; "Book No.", "Author No.")
        {
            Clustered = true;
        }
    }
}
