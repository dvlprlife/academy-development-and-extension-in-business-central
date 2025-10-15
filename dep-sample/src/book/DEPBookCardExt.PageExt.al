namespace SummitNA.BookManagementExt.BookExt;

using SummitNA.BookManagement.Book;

pageextension 50120 "DEP Book Card Ext" extends "DEV Book Card"
{
    layout
    {
        modify(BookType)
        {
            Caption = 'Type';
        }

        moveafter(Status; Title)

        addlast(General)
        {
            field(DEPYear; Rec."DEP Year")
            {
                ApplicationArea = All;
            }
        }

        addfirst(Description)
        {
            field(DEPPrice; Rec."DEP Price")
            {
                ApplicationArea = All;
            }

        }
    }
}