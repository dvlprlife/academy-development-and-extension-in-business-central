page 50104 "DEV Book Authors"
{
    ApplicationArea = All;
    Caption = 'Book Authors';
    PageType = List;
    SourceTable = "DEV Book Author";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Author  No."; Rec."Author No.")
                {
                    ToolTip = 'Specifies the value of the Author No. field.';
                }
                field("Author Last Name"; Rec."Author Last Name")
                {
                    ToolTip = 'Specifies the value of the Author Name field.';
                }
                field("Author Name"; FullName)
                {
                    Caption = 'Full Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Author Name field.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Author: Record "DEV Author";
    begin
        FullName := Author.GetAuthorName(Rec."Author No.");
    end;

    var
        FullName: Text[100];
}
