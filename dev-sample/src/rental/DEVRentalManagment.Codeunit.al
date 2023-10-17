codeunit 50101 "DEV Rental Managment"
{
    Access = Internal;
    Subtype = Normal;
    TableNo = "DEV Book Rental Header";
    trigger OnRun()
    begin
        CheckRental(Rec);
    end;

    procedure CheckRental(var BookRentalHeader: Record "DEV Book Rental Header")
    var
        BookRentalLine: Record "DEV Book Rental Line";
    begin
        BookRentalLine.SetRange("Rental Header No.", BookRentalHeader."No.");
        if BookRentalLine.FindSet() then
            repeat
                CheckLine(BookRentalLine);
            until BookRentalLine.Next() = 0;

    end;

    local procedure CheckLine(BookRentalLine: Record "DEV Book Rental Line")
    var
        Book: Record "DEV Book";
    begin
        Book.Get(BookRentalLine."Book No.");
        Book.TestField(Status, "DEV Book Status"::Available);
    end;
}
