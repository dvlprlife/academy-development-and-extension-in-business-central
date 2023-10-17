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
            Caption = 'Author Name';
            FieldClass = FlowField;
            CalcFormula = lookup("DEV Author"."Last Name" where("No." = field("Author No.")));
            Editable = false;
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
