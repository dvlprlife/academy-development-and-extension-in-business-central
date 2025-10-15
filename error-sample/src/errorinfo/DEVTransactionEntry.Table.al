namespace SummitNA.Academy.Error;

using Microsoft.Inventory.Item;

table 50150 "DEV Transaction Entry"
{
    Caption = 'Transaction Entry';
    DataClassification = CustomerContent;
    DrillDownPageId = "DEV Transaction Entries";
    LookupPageId = "DEV Transaction Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the unique entry number for the transaction entry.';
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = Item;
            ToolTip = 'Specifies the code associated with the transaction entry.';
        }
        field(10; Quantity; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantity';
            ToolTip = 'Specifies the quantity for the transaction entry.';

            trigger OnValidate()
            begin
                UpdateUnitPrice(FieldNo(Quantity));
            end;
        }
        field(15; "Unit Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Unit Price';
            ToolTip = 'Specifies the unit price for the transaction entry.';

            trigger OnValidate()
            begin
                UpdateUnitPrice(FieldNo("Unit Price"));
            end;
        }
        field(20; "Line Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Line Amount';
            DecimalPlaces = 2 : 2;
            ToolTip = 'Specifies the total line amount for the transaction entry.';

            trigger OnValidate()
            begin
                UpdateUnitPrice(FieldNo("Line Amount"));
            end;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure GetEntryNo(): Integer
    var
        TransactionEntry: Record "DEV Transaction Entry";
    begin
        if TransactionEntry.IsEmpty() then
            exit(1)
        else begin
            TransactionEntry.FindLast();
            exit(TransactionEntry."Entry No." + 1);
        end;
    end;

    procedure UpdateUnitPrice(CalledByFieldNo: Integer)
    begin
        case CalledByFieldNo of
            FieldNo(Quantity), FieldNo("Unit Price"):
                "Line Amount" := Quantity * "Unit Price";
            FieldNo("Line Amount"):
                begin
                    if Quantity = 0 then
                        Quantity := 1;
                    "Unit Price" := "Line Amount" / Quantity;
                end;
        end;
    end;
}
