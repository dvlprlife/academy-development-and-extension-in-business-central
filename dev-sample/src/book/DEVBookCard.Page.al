page 50102 "DEV Book Card"
{
    ApplicationArea = All;
    Caption = 'Book Card';
    PageType = Card;
    SourceTable = "DEV Book";
    DataCaptionFields = "No.", Title;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field("Book Type"; Rec."Book Type")
                {
                    ToolTip = 'Specifies the value of the Book Type field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the status field.';
                }
            }
            group(Description)
            {
                Caption = 'Description';
                field("Short Description"; Rec."Short Description")
                {
                    ToolTip = 'Specifies the value of the Description field.';
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

    var
        LongDescriptionText: Text;

    trigger OnAfterGetRecord()
    begin
        LongDescriptionText := GetLongDescription();
    end;

    procedure GetLongDescription() escriptionText: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields("Description");
        Rec.Description.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName("Description")));
    end;

    procedure SetLongDescription(DescriptionText: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec.Description);
        Rec.Description.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(DescriptionText);
        Rec.Modify();
    end;
}
