permissionset 50100 "DEV Book Admin"
{
    Assignable = true;
    Caption = 'Book Admin';
    Permissions = table "DEV Author" = X,
        tabledata "DEV Author" = RIMD,
        table "DEV Author Type" = X,
        tabledata "DEV Author Type" = RIMD,
        table "DEV Book" = X,
        tabledata "DEV Book" = RIMD,
        table "DEV Book Author" = X,
        tabledata "DEV Book Author" = RIMD,
        table "DEV Book Rental Header" = X,
        tabledata "DEV Book Rental Header" = RIMD,
        table "DEV Book Rental Line" = X,
        tabledata "DEV Book Rental Line" = RIMD;
}