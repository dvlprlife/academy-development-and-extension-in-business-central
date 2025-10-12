namespace SummitNA.BookManagementExt.BookExt;

using SummitNA.BookManagement.Book;

tableextension 50120 "DEP Book Ext" extends "DEV Book"
{
    fields
    {
        field(50120; "DEP Year"; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            ToolTip = 'The year of publication of the book';
        }
        field(50121; "DEP Price"; Decimal)
        {
            Caption = 'Price';
            DataClassification = CustomerContent;
            MinValue = 0;
            ToolTip = 'The price of  the book';
        }
    }
}
