namespace SummitNA.BookManagement.Author;

page 50110 "DEV Author Type List"
{
    ApplicationArea = All;
    Caption = 'Author Type List';
    PageType = List;
    SourceTable = "DEV Author Type";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec."Code")
                {
                    ToolTip = 'Specifies the code for the author type.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the author type.';
                }
            }
        }
    }
}
