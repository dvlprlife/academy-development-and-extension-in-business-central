namespace SummitNA.Academy.Error;

page 50150 "DEV Transaction Entries"
{
    ApplicationArea = All;
    Caption = 'Transaction Entries';
    PageType = List;
    SourceTable = "DEV Transaction Entry";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.") { }
                field("Code"; Rec."Code") { }
                field(Quantity; Rec.Quantity) { }
                field("Unit Price"; Rec."Unit Price") { }
                field("Line Amount"; Rec."Line Amount") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateDemoData)
            {
                Caption = 'Create Demo Data';
                Image = Database;
                ToolTip = 'Creates demo data in the Transaction Entries table.';

                trigger OnAction()
                var
                    ErrorMgmt: Codeunit "DEV Error Management";
                begin
                    ErrorMgmt.CreateDemoData();
                    Rec.FindSet();
                    CurrPage.Update();
                end;
            }
            group(ErrorChecking)
            {
                Caption = 'Error Checking';
                Image = Warning;
                action(CheckLines1)
                {
                    Caption = 'Check Lines 1';
                    ToolTip = 'Checks the transaction entries for data inconsistencies.';

                    trigger OnAction()
                    var
                        ErrorMgmt: Codeunit "DEV Error Management";
                    begin
                        ErrorMgmt.CheckLines1();
                    end;
                }
                action(CheckLines2)
                {
                    Caption = 'Check Lines 2';
                    ToolTip = 'Checks the transaction entries for data inconsistencies.';

                    trigger OnAction()
                    var
                        ErrorMgmt: Codeunit "DEV Error Management";
                    begin
                        ErrorMgmt.CheckLines2();
                    end;
                }
                action(CheckLines3)
                {
                    Caption = 'Check Lines 3';
                    ToolTip = 'Checks the transaction entries for data inconsistencies.';

                    trigger OnAction()
                    var
                        ErrorMgmt: Codeunit "DEV Error Management";
                    begin
                        ErrorMgmt.CheckLines3();
                    end;
                }
                action(CheckLines4)
                {
                    Caption = 'Check Lines 4';
                    ToolTip = 'Checks the transaction entries for data inconsistencies.';

                    trigger OnAction()
                    var
                        ErrorMgmt: Codeunit "DEV Error Management";
                    begin
                        ErrorMgmt.CheckLines4();
                    end;
                }
            }
            group(ErrorActions)
            {
                Caption = 'Error Actions';
                Image = Error;
                action(ShowErrors)
                {
                    Caption = 'Show Errors';
                    ToolTip = 'Shows the collected errors.';

                    trigger OnAction()
                    var
                        ErrorMgmt: Codeunit "DEV Error Management";
                    begin
                        ErrorMgmt.CheckLineErrorAction(Rec);
                    end;
                }
            }
        }
        area(Promoted)
        {
            actionref(CreateDemoDataRef; CreateDemoData) { }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Entry No." := Rec.GetEntryNo();
    end;
}
