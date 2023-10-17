permissionset 50200 "DEV Widget"
{
    Assignable = true;
    Caption = 'Widget';
    Permissions = tabledata "DEV Widget" = RIMD,
        table "DEV Widget" = X,
        page "DEV Widget Entity" = X,
        page "DEV Widget List" = X;
}