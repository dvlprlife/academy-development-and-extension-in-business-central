page 50200 "DEV Widget Entity"
{
    APIGroup = 'sample';
    APIPublisher = 'summitNA';
    APIVersion = 'v2.0';
    ApplicationArea = All;
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
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id', Locked = true;
                    Editable = false;
                }
                field(no; Rec."No.")
                {
                    Caption = 'no', Locked = true;
                }
                field(description; Rec.Description)
                {
                    Caption = 'description', Locked = true;
                }
                field(combinedtext; combinedText)
                {
                    Caption = 'combinedText', Locked = true;
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
