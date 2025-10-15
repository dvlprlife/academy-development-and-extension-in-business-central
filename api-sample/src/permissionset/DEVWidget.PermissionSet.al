permissionset 50200 "DEV Widget"
{
    Assignable = true;
    Caption = 'Widget';
    Permissions = tabledata "DEV Widget" = RIMD,
        table "DEV Widget" = X,
        page "DEV Widget Entity" = X,
        page "DEV Widget List" = X,
        tabledata "DEV Stock" = RIMD,
        tabledata "DEV Time Series Data" = RIMD,
        table "DEV Stock" = X,
        table "DEV Time Series Data" = X,
        page "DEV Stock List" = X,
        page "DEV Time Series Data List" = X;
}