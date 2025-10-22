namespace SummitNA.API.Stock;

codeunit 50201 "DEV Storage Management"
{
    Access = Internal;

    [NonDebuggable]
    procedure GetAPIKey(): Text
    var
        Value: Code[80];
    begin
        if not Evaluate(Value, GetStorageValue(GetAPIStorageKey())) or (Value = '') then
            Value := 'DEMO';
        exit(Value);
    end;

    [NonDebuggable]
    procedure SetAPIKey(Value: Text)
    begin
        SaveStorageValue(GetAPIStorageKey(), Value);
    end;

    [NonDebuggable]
    local procedure GetAPIStorageKey(): Text[80]
    begin
        exit('AlphaVantageAPIKey');
    end;

    [NonDebuggable]
    local procedure GetStorageValue(StorageKey: Text): Text
    var
        StorageValue: Text;
    begin
        if IsolatedStorage.Contains(StorageKey, DataScope::Module) then
            if not IsolatedStorage.Get(StorageKey, DataScope::Module, StorageValue) then
                StorageValue := '';
        exit(StorageValue);
    end;

    [NonDebuggable]
    local procedure SaveStorageValue(StorageKey: Text; StorageValue: Text)
    begin
        if IsolatedStorage.Contains(StorageKey, DataScope::Module) then
            IsolatedStorage.Delete(StorageKey);
        IsolatedStorage.Set(StorageKey, StorageValue, DataScope::Module);
    end;
}
