codeunit 50121 "DEP Number Management"
{

    procedure AddNumbers(number1: Integer; number2: Integer): Integer
    begin
        exit(number1 + number2);
    end;

    procedure AddNumbers(number1: Decimal; number2: Decimal): Decimal
    begin
        exit(number1 + number2);
    end;

    procedure DivideNumbers(number1: Integer; number2: Integer): Integer
    begin
        if number2 = 0 then
            exit(0);

        exit(number1 / number2);
    end;

    procedure ModuloNumbers(number1: Integer; number2: Integer): Integer
    begin
        exit(number1 MOD number2);
    end;

    procedure MultiplyNumbers(number1: Integer; number2: Integer): Integer
    begin
        exit(number1 * number2);
    end;

    procedure SubtractNumbers(number1: Integer; number2: Integer): Integer
    begin
        exit(number1 - number2);
    end;
}
