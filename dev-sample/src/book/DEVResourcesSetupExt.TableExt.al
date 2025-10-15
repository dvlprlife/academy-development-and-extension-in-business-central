namespace SummitNA.BookManagement.Book;

using Microsoft.Foundation.NoSeries;
using Microsoft.Projects.Resources.Setup;
tableextension 50101 "DEV Resources Setup Ext" extends "Resources Setup"
{
    fields
    {
        field(50100; "DEV Author Nos."; Code[20])
        {
            Caption = 'Author Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            ToolTip = 'Specifies the author number series.';
        }
        field(50101; "DEV Book Nos."; Code[20])
        {
            Caption = 'Book Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            ToolTip = 'Specifies the book number series.';
        }
        field(50102; "DEV Rental Nos."; Code[20])
        {
            Caption = 'Rental Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            ToolTip = 'Specifies the rental number series.';
        }
    }
}
