namespace SummitNA.Academy.Error;

using Microsoft.Inventory.Item;
using SummitNA.Academy.Error;

codeunit 50150 "DEV Action Management"
{
    procedure ErrAddItem(ErrorInfo: ErrorInfo)
    var
        TransactionEntry: Record "DEV Transaction Entry";
        Item: Record Item;
        ItemCard: Page "Item Card";
    begin
        TransactionEntry.GetBySystemId(ErrorInfo.SystemId);
        Item.Init();
        Item.Validate("No.", TransactionEntry.Code);
        Item.Description := 'New Item from Error Action';
        Item.Insert();
        ItemCard.SetRecord(Item);
        ItemCard.Run();
    end;

    procedure ErrFixEntry(ErrorInfo: ErrorInfo)
    var
        TransactionEntry: Record "DEV Transaction Entry";
        TransactionEntries: Page "DEV Transaction Entries";
    begin
        TransactionEntry.GetBySystemId(ErrorInfo.SystemId);
        TransactionEntries.SetRecord(TransactionEntry);
        TransactionEntries.LookupMode(false);
        TransactionEntries.RunModal();
    end;
}
