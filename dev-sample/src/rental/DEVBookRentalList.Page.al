namespace SummitNA.BookManagement.Rental;

page 50108 "DEV Book Rental List"
{
    AnalysisModeEnabled = false;
    ApplicationArea = All;
    Caption = 'Book Rental List';
    CardPageId = "DEV Book Rental";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "DEV Book Rental Header";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(ContractDate; Rec."Contract Date")
                {
                }
                field(ContactNo; Rec."Contact No.")
                {
                }
                field(ContactName; Rec."Contact Name")
                {
                }
            }
        }
    }
}
