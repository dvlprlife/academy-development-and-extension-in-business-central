table 50104 "DEV Book Rental Line"
{
    Caption = 'Book Rental Line';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Rental Header No."; Code[20])
        {
            Caption = 'Rental No.';
            TableRelation = "DEV Book Rental Header"."No.";
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(20; "Book No."; Code[20])
        {
            Caption = 'Book No.';
            TableRelation = "DEV Book"."No." where(Status = CONST("DEV Book Status"::Available));
        }
        field(25; "Book Title"; Text[50])
        {
            Caption = 'Book Title';
            FieldClass = FlowField;
            CalcFormula = lookup("DEV Book".Title where("No." = field("Book No.")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Rental Header No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
