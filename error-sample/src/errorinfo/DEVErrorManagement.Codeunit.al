namespace SummitNA.Academy.Error;

using Microsoft.Inventory.Item;

codeunit 50151 "DEV Error Management"
{
    var
        DataErr: Label 'Data inconsistency found in Entry No. %1: Quantity (%2) * Unit Price (%3) <> Line Amount (%4)', Comment = '% 1 Entry No. %2 Quantity %3 Unit Price %4 Line Amount';

    procedure CheckLineErrorAction(TransactionEntry: Record "DEV Transaction Entry")
    var
        Item: Record Item;
        TransErrorInfo: ErrorInfo;
    begin
        if not Item.Get(TransactionEntry.Code) then begin
            Clear(TransErrorInfo);
            TransErrorInfo.Title := 'Error Demonstration';
            TransErrorInfo.ErrorType := ErrorType::Client;
            TransErrorInfo.Verbosity := Verbosity::Error;
            TransErrorInfo.DataClassification := DataClassification::CustomerContent;
            TransErrorInfo.SystemId := TransactionEntry.SystemId;
            TransErrorInfo.Message := StrSubstNo('%1 %2 does not. exist. What would you like to do?', Item.TableCaption, TransactionEntry."Code");
            TransErrorInfo.AddAction('Add Item', Codeunit::"DEV Action Management", 'ErrAddItem');
            TransErrorInfo.AddAction('Fix Entry', Codeunit::"DEV Action Management", 'ErrFixEntry');

            Error(TransErrorInfo);
        end;
    end;

    procedure CheckLines1()
    var
        TransactionEntry: Record "DEV Transaction Entry";
    begin
        if TransactionEntry.FindSet() then
            repeat
                if (TransactionEntry.Quantity * TransactionEntry."Unit Price") <> TransactionEntry."Line Amount" then
                    TransactionEntry.FieldError("Line Amount");
            until TransactionEntry.Next() = 0;
    end;

    procedure CheckLines2()
    var
        TransactionEntry: Record "DEV Transaction Entry";
    begin
        if TransactionEntry.FindSet() then
            repeat
                if (TransactionEntry.Quantity * TransactionEntry."Unit Price") <> TransactionEntry."Line Amount" then
                    TransactionEntry.FieldError("Line Amount",
                    StrSubstNo(DataErr, TransactionEntry."Entry No.", TransactionEntry.Quantity, TransactionEntry."Unit Price", TransactionEntry."Line Amount"));
            until TransactionEntry.Next() = 0;
    end;

    procedure CheckLines3()
    var
        TransactionEntry: Record "DEV Transaction Entry";
        TransErrorInfo: ErrorInfo;
    begin
        if TransactionEntry.FindSet() then
            repeat

                if (TransactionEntry.Quantity * TransactionEntry."Unit Price") <> TransactionEntry."Line Amount" then begin
                    Clear(TransErrorInfo);
                    TransErrorInfo := ErrorInfo.Create(StrSubstNo('%1 %2', TransactionEntry.FieldCaption("Entry No."), TransactionEntry."Entry No."));
                    // Specifies type of the error. 'Client' shows the specified message in the client and sends it to telemetry. 'Internal' shows a generic message in the client and sends the specified message to telemetry.
                    TransErrorInfo.ErrorType(ErrorType::Client);
                    TransErrorInfo.DataClassification := DataClassification::CustomerContent;
                    TransErrorInfo.Verbosity := Verbosity::Error;
                    // Specifies the message that will be sent to telemetry. For a 'Client' error type, the message will also be appear in the client.
                    TransErrorInfo.Message(StrSubstNo('Data inconsistency found in Entry No. %1', TransactionEntry."Entry No."));
                    TransErrorInfo.Collectible(true);
                    Error(TransErrorInfo);
                end;
            until TransactionEntry.Next() = 0;
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure CheckLines4()
    var
        TransactionEntry: Record "DEV Transaction Entry";
        TransErrorInfo: ErrorInfo;
    begin
        if TransactionEntry.FindSet() then
            repeat
                if (TransactionEntry.Quantity * TransactionEntry."Unit Price") <> TransactionEntry."Line Amount" then begin
                    Clear(TransErrorInfo);
                    TransErrorInfo := ErrorInfo.Create(StrSubstNo('%1 %2', TransactionEntry.FieldCaption("Entry No."), TransactionEntry."Entry No."));
                    // Specifies the message that will be sent to telemetry. For a 'Client' error type, the message will also be appear in the client.
                    TransErrorInfo.Message(StrSubstNo('Data inconsistency found in Entry No. %1', TransactionEntry."Entry No."));
                    TransErrorInfo.Collectible(true);
                    Error(TransErrorInfo);
                end;
            until TransactionEntry.Next() = 0;
    end;

    procedure CreateDemoData()
    var
        TransactionEntry: Record "DEV Transaction Entry";
    begin
        // Clear existing demo data
        TransactionEntry.DeleteAll();

        // Create sample transaction entries
        CreateTransactionEntry('ITEM001', 5, 10.50, 50.50);
        CreateTransactionEntry('ITEM002', 10, 25.00, 0);
        CreateTransactionEntry('ITEM003', 2, 150.75, 0);
        CreateTransactionEntry('ITEM004', 8, 12.99, 100);
        CreateTransactionEntry('ITEM005', 15, 5.50, 0);
        CreateTransactionEntry('ITEM006', 3, 99.99, 0);
        CreateTransactionEntry('ITEM007', 20, 2.25, 0);
        CreateTransactionEntry('ITEM008', 1, 500.00, 400);
        CreateTransactionEntry('ITEM009', 12, 8.75, 0);
        CreateTransactionEntry('ITEM010', 6, 45.00, 0);

        Message('Demo data created successfully. %1 records inserted.', 10);
    end;

    local procedure CreateTransactionEntry(ItemCode: Code[10]; Quantity: Decimal; UnitPrice: Decimal; LineAmount: Decimal)
    var
        TransactionEntry: Record "DEV Transaction Entry";
    begin
        TransactionEntry.Init();
        TransactionEntry."Entry No." := TransactionEntry.GetEntryNo();
        TransactionEntry.Code := ItemCode;
        TransactionEntry.Validate(Quantity, Quantity);
        TransactionEntry.Validate("Unit Price", UnitPrice);
        if LineAmount <> 0 then
            TransactionEntry."Line Amount" := LineAmount;
        TransactionEntry.Insert(true);
    end;
}