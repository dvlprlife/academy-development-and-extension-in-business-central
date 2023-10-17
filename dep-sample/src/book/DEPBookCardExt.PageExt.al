pageextension 50120 "DEP Book Card Ext" extends "DEV Book Card"
{
    layout
    {
        modify("Book Type")
        {
            Caption = 'Type';
        }

        moveafter(Status; Title)

        addlast(General)
        {
            field(DEPYear; Rec."DEP Year")
            {
                ApplicationArea = All;
                ToolTip = 'The year of publication of the book';
            }
        }

        addfirst(Description)
        {
            field(DEPPrice; Rec."DEP Price")
            {
                ApplicationArea = All;
                ToolTip = 'The price of  the book';
            }

        }
    }
}