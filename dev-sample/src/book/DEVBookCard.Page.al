namespace SummitNA.BookManagement.Book;

using System.Reflection;
page 50102 "DEV Book Card"
{
    ApplicationArea = All;
    Caption = 'Book Card';
    DataCaptionFields = "No.", Title;
    PageType = Card;
    SourceTable = "DEV Book";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(BookType; Rec."Book Type")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
            group(Description)
            {
                Caption = 'Description';
                field("Short Description"; Rec."Short Description")
                {
                }
                group(LongDescription)
                {
                    Caption = 'Long Description';
                    field(ExtDescription; LongDescriptionText)
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the products or service being offered.';

                        trigger OnValidate()
                        begin
                            SetLongDescription(LongDescriptionText);
                        end;
                    }
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Authors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Authors';
                Image = Resource;
                RunObject = page "DEV Book Authors";
                RunPageLink = "Book No." = field("No.");
                ToolTip = 'View or edit the authors for this book.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        LongDescriptionText := GetLongDescription();
    end;

    var
        LongDescriptionText: Text;

    procedure GetLongDescription() DescriptionText: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields(Description);
        Rec.Description.CreateInStream(InStream, TextEncoding::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName(Description)));
    end;

    procedure SetLongDescription(DescriptionText: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec.Description);
        Rec.Description.CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(DescriptionText);
        Rec.Modify();
    end;
}
