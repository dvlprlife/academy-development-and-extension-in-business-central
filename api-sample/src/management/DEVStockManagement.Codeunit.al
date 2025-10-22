namespace SummitNA.API.Stock;

using System.Reflection;

codeunit 50200 "DEV Stock Management"
{

    procedure RetrieveStockPrice(Symbol: Code[10]; TimeSeries: Enum "DEV Time Series"; MetaDictionary: Dictionary of [Text, Text]; var TimeSeriesData: Record "DEV Time Series Data" temporary)
    var
        StockDataJsonText: Text;
    begin
        SendRequest(Symbol, TimeSeries, StockDataJsonText);
        ProcessStockData(StockDataJsonText, MetaDictionary, TimeSeriesData);
    end;

    [NonDebuggable]
    local procedure GetURI(Symbol: Code[10]; TimeSeries: Enum "DEV Time Series"): Text
    var
        StorageManagement: Codeunit "DEV Storage Management";
        TimeSeriesText: Text;
        URI: Text;
    begin
        TimeSeriesText := TimeSeries.Names.Get(TimeSeries.Ordinals.IndexOf(TimeSeries.AsInteger()));
        URI := StrSubstNo('https://www.alphavantage.co/query?function=%2&symbol=%1&outputsize=full&apikey=%3', Symbol, TimeSeriesText, StorageManagement.GetAPIKey());
        exit(URI);
    end;

    local procedure ProcessMetaData(MetaDataJsonObject: JsonObject; MetaDictionary: Dictionary of [Text, Text])
    var
        JsonToken: JsonToken;
    begin
        if MetaDataJsonObject.Get('1. Information', JsonToken) then
            MetaDictionary.Add('Information', JsonToken.AsValue().AsText());
        if MetaDataJsonObject.Get('2. Symbol', JsonToken) then
            MetaDictionary.Add('Symbol', JsonToken.AsValue().AsText());
        if MetaDataJsonObject.Get('3. Last Refreshed', JsonToken) then
            MetaDictionary.Add('Last Refreshed', JsonToken.AsValue().AsText());
        if MetaDataJsonObject.Get('4. Output Size', JsonToken) then
            MetaDictionary.Add('Output Size', JsonToken.AsValue().AsText());
        if MetaDataJsonObject.Get('5. Time Zone', JsonToken) then
            MetaDictionary.Add('Time Zone', JsonToken.AsValue().AsText());
    end;

    local procedure ProcessStockData(StockDataJsonText: Text; MetaDictionary: Dictionary of [Text, Text]; var TimeSeriesData: Record "DEV Time Series Data" temporary)
    var
        JsonObject: JsonObject;
        MetaDataJsonObject: JsonObject;
        TimeSeriesJsonObject: JsonObject;
        JsonToken: JsonToken;
    begin
        if StockDataJsonText = '' then
            exit;
        if not JsonObject.ReadFrom(StockDataJsonText) then
            Error('Invalid JSON response');

        // Get Meta Data
        if not JsonObject.Get('Meta Data', JsonToken) then
            Error('Meta Data not found in response');
        MetaDataJsonObject := JsonToken.AsObject();
        ProcessMetaData(MetaDataJsonObject, MetaDictionary);

        if not JsonObject.Get('Time Series (Daily)', JsonToken) then
            Error('Time Series data not found in response');
        TimeSeriesJsonObject := JsonToken.AsObject();
        ProcessTimeSeriesData(TimeSeriesJsonObject, TimeSeriesData);
    end;

    local procedure ProcessTimeSeriesData(TimeSeriesJsonObject: JsonObject; var TimeSeriesData: Record "DEV Time Series Data" temporary)
    var
        EntryDate: Date;
        i: Integer;
        DailyDataJsonObject: JsonObject;
        JsonToken: JsonToken;
        Keys: List of [Text];
        DateKey: Text;
    begin
        // Get all date keys from the Time Series (Daily) object
        Keys := TimeSeriesJsonObject.Keys();

        // Iterate through each date
        for i := 1 to Keys.Count() do begin
            DateKey := Keys.Get(i);

            // Get the data for this date
            if TimeSeriesJsonObject.Get(DateKey, JsonToken) then begin
                DailyDataJsonObject := JsonToken.AsObject();

                TimeSeriesData.Init();
                TimeSeriesData."Entry No." := i;
                Evaluate(EntryDate, DateKey);
                TimeSeriesData."Date" := EntryDate;

                if DailyDataJsonObject.Get('1. open', JsonToken) then
                    TimeSeriesData.Open := JsonToken.AsValue().AsDecimal();
                if DailyDataJsonObject.Get('2. high', JsonToken) then
                    TimeSeriesData.High := JsonToken.AsValue().AsDecimal();
                if DailyDataJsonObject.Get('3. low', JsonToken) then
                    TimeSeriesData.Low := JsonToken.AsValue().AsDecimal();
                if DailyDataJsonObject.Get('4. close', JsonToken) then
                    TimeSeriesData.Close := JsonToken.AsValue().AsDecimal();
                if DailyDataJsonObject.Get('5. volume', JsonToken) then
                    TimeSeriesData.Volume := JsonToken.AsValue().AsInteger();
                TimeSeriesData.Insert();
            end;
        end;
    end;

    local procedure SendRequest(Symbol: Code[10]; TimeSeries: Enum "DEV Time Series"; var ResponseBody: Text): Boolean
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
    begin
        HttpRequestMessage.SetRequestUri(GetURI(Symbol, TimeSeries));
        HttpRequestMessage.Method := 'GET';
        HttpClient.Timeout := 6000;

        // NavApp.GetCurrentModuleInfo(ModuleInfo);
        // AppVersion := ModuleInfo.AppVersion;
        HttpClient.DefaultRequestHeaders().Clear();
        // HttpClient.DefaultRequestHeaders().Add('Application', ModuleInfo.Name);
        // HttpClient.DefaultRequestHeaders().Add('AppVersion', Format(AppVersion));
        HttpClient.DefaultRequestHeaders().Add('Accept', 'application/json');

        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
            HttpResponseMessage.Content().ReadAs(ResponseBody);
            if not HttpResponseMessage.IsSuccessStatusCode() then
                Error('%1 %2 %3', HttpResponseMessage.HttpStatusCode(), HttpResponseMessage.ReasonPhrase, ResponseBody);
        end else
            Error('Error: %1', GetLastErrorText());
    end;
}
