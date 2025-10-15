namespace SummitNA.BookManagementExt.Management;

using SummitNA.BookManagement.Author;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Document;


codeunit 50120 "DEP Event Subscribers"
{
    // [EventSubscriber(ObjectType: ObjectType, ObjectId: Integer, EventName: Text, ElementName: Text, SkipOnMissingLicense: Boolean, SkipOnMissingPermission: Boolean)]

    [EventSubscriber(ObjectType::Table, Database::"DEV Author", 'OnBeforeInsert', '', false, false)]
    local procedure AuthorOnBeforeInsert(var Author: Record "DEV Author"; var Handled: Boolean)
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Name', false, false)]
    local procedure CustomerOnAfterModifyEvent(var Rec: Record Customer; var xRec: Record Customer)
    begin
        Rec.Validate("Name 2", CopyStr(xRec.Name, 1, MaxStrLen(Rec."Name 2")));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    begin

    end;
}
