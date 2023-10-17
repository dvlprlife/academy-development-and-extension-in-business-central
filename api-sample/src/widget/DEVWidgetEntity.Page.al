page 50200 "DEV Widget Entity"
{

    APIGroup = 'sample';
    APIPublisher = 'summitNA';
    APIVersion = 'v2.0';
    Caption = 'widgetEntity', Locked = true;
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    EntityName = 'widget';
    EntitySetName = 'widgets';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = "DEV Widget";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    ApplicationArea = All;
                    Caption = 'Id', Locked = true;
                    Editable = false;
                }
                field(no; Rec."No.")
                {
                    ApplicationArea = All;
                    caption = 'no', Locked = true;
                }
                field(description; Rec.Description)
                {
                    ApplicationArea = All;
                    caption = 'description', Locked = true;
                }
                field(combinedtext; combinedText)
                {
                    ApplicationArea = All;
                    caption = 'combinedText', Locked = true;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        combinedText := Rec."No." + ' ' + Rec.Description;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Random := Random(100);
    end;

    var
        combinedText: Text;
}
