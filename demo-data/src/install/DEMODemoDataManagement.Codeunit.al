namespace SummitNA.BookManagement.DemoData;




using Microsoft.Foundation.NoSeries;
using Microsoft.Projects.Resources.Setup;
using SummitNA.BookManagement.Author;
using SummitNA.BookManagement.Book;

codeunit 50320 "DEMO Demo Data Management"
{
    Subtype = Install;

    trigger OnInstallAppPerDatabase()
    begin
        // Code for database related operations
    end;

    trigger OnInstallAppPerCompany()
    begin
        If DemoDataAlreadyExists() then
            exit;

        CreateNumbering();
        CreateDemoAuthorTypes();
        CreateDemoAuthors();
        CreateDemoBooks();
    end;

    local procedure CreateAuthor(FirstName: Text[30]; MiddleName: Text[30]; LastName: Text[30]; AuthorAddress: Text[100]; Address2: Text[50]; AuthorCity: Text[30]; PostCode: Code[20]; AuthorCounty: Text[30]; PhoneNo: Text[30]; Email: Text[80]; SSN: Text[30]; AuthorStatus: Enum "DEV Author Status"): Code[20]
    var
        Author: Record "DEV Author";
    begin
        Author.Init();
        Author.Validate("First Name", FirstName);
        Author.Validate("Middle Name", MiddleName);
        Author.Validate("Last Name", LastName);
        Author.Validate(Address, AuthorAddress);
        Author.Validate("Address 2", Address2);
        Author.Validate(City, AuthorCity);
        Author.Validate("Post Code", PostCode);
        Author.Validate(County, AuthorCounty);
        Author.Validate("Phone No.", PhoneNo);
        if Email <> '' then
            Author.Validate("E-Mail", Email);
        Author.Validate("Social Security No.", SSN);
        Author.Validate(Status, AuthorStatus);
        Author.Insert(true);
        exit(Author."No.");
    end;

    local procedure CreateAuthorType(TypeCode: Code[10]; TypeDescription: Text[100])
    var
        AuthorType: Record "DEV Author Type";
    begin
        if not AuthorType.Get(TypeCode) then begin
            AuthorType.Init();
            AuthorType.Validate(Code, TypeCode);
            AuthorType.Validate(Description, TypeDescription);
            AuthorType.Insert(true);
        end;
    end;

    local procedure CreateBook(BookTitle: Text[50]; ShortDesc: Text[50]; DescriptionText: Text; BookType: Enum "DEV Book Type"; BookStatus: Enum "DEV Book Status"): Code[20]
    var
        Book: Record "DEV Book";
        OutStr: OutStream;
    begin
        Book.Init();
        Book.Validate(Title, BookTitle);
        Book.Validate("Short Description", ShortDesc);
        if DescriptionText <> '' then begin
            Book.Description.CreateOutStream(OutStr);
            OutStr.WriteText(DescriptionText);
        end;
        Book.Validate("Book Type", BookType);
        Book.Validate(Status, BookStatus);
        Book.Insert(true);
        exit(Book."No.");
    end;

    local procedure CreateDemoAuthors()
    begin
        CreateAuthor('Margaret', 'Eleanor', 'Atwood', '123 Literary Lane', 'Suite 100', 'Toronto', 'M5H 2N2', 'Ontario', '416-555-0101', 'margaret.atwood@example.com', '', "DEV Author Status"::Active);
        CreateAuthor('George', 'R.R.', 'Martin', '456 Fantasy Boulevard', '', 'Santa Fe', '87501', 'New Mexico', '505-555-0202', 'george.martin@example.com', '', "DEV Author Status"::Active);
        CreateAuthor('Jane', 'K.', 'Rowling', '789 Wizarding Way', 'Apt 9 3/4', 'Edinburgh', 'EH1 1YZ', 'Scotland', '131-555-0303', 'j.rowling@example.com', '', "DEV Author Status"::Active);
        CreateAuthor('Stephen', 'Edwin', 'King', '321 Horror Heights', '', 'Bangor', '04401', 'Maine', '207-555-0404', 'stephen.king@example.com', '', "DEV Author Status"::Active);
        CreateAuthor('Agatha', 'Mary', 'Christie', '654 Mystery Manor', '', 'Torquay', 'TQ1 1AA', 'Devon', '180-555-0505', 'agatha.christie@example.com', '', "DEV Author Status"::Inactive);
        CreateAuthor('Isaac', '', 'Asimov', '987 Science Street', 'Building B', 'New York', '10001', 'New York', '212-555-0606', 'isaac.asimov@example.com', '', "DEV Author Status"::Inactive);
        CreateAuthor('Virginia', '', 'Woolf', '147 Bloomsbury Square', '', 'London', 'WC1A 2LP', 'England', '207-555-0707', 'virginia.woolf@example.com', '', "DEV Author Status"::Inactive);
        CreateAuthor('Ernest', 'Miller', 'Hemingway', '258 Adventure Avenue', '', 'Key West', '33040', 'Florida', '305-555-0808', 'ernest.hemingway@example.com', '', "DEV Author Status"::Inactive);
        CreateAuthor('Toni', '', 'Morrison', '369 Nobel Drive', 'Unit 5', 'Princeton', '08540', 'New Jersey', '609-555-0909', 'toni.morrison@example.com', '', "DEV Author Status"::Active);
        CreateAuthor('Haruki', '', 'Murakami', '741 Surreal Circle', '', 'Tokyo', '100-0001', 'Tokyo', '033-555-1010', 'haruki.murakami@example.com', '', "DEV Author Status"::Active);
    end;

    local procedure CreateDemoAuthorTypes()
    begin
        CreateAuthorType('FICTION', 'Fiction Author');
        CreateAuthorType('NONFICTION', 'Non-Fiction Author');
        CreateAuthorType('BIOGRAPHY', 'Biography Writer');
        CreateAuthorType('TECHNICAL', 'Technical Writer');
        CreateAuthorType('ACADEMIC', 'Academic Writer');
    end;

    local procedure CreateDemoBooks()
    begin
        // Fiction Books
        CreateBook('The Handmaid''s Tale', 'Dystopian classic', 'A haunting tale of a totalitarian society where women have lost all rights and freedoms.', "DEV Book Type"::Fiction, "DEV Book Status"::Available);
        CreateBook('A Game of Thrones', 'Epic fantasy series begins', 'The first book in the epic fantasy series that follows noble families vying for control of the Iron Throne.', "DEV Book Type"::Fiction, "DEV Book Status"::Available);
        CreateBook('Harry Potter and the Sorcerer''s Stone', 'Magical adventure', 'A young wizard discovers his magical heritage and attends Hogwarts School of Witchcraft and Wizardry.', "DEV Book Type"::Fiction, "DEV Book Status"::Available);
        CreateBook('The Shining', 'Psychological horror', 'A family becomes winter caretakers of an isolated hotel where supernatural forces push the father toward violence.', "DEV Book Type"::Fiction, "DEV Book Status"::Available);
        CreateBook('Murder on the Orient Express', 'Classic mystery', 'Detective Hercule Poirot investigates a murder aboard the famous train where every passenger is a suspect.', "DEV Book Type"::Fiction, "DEV Book Status"::Available);
        CreateBook('Foundation', 'Science fiction epic', 'A mathematician develops a theory to predict and shorten the coming dark age of galactic civilization.', "DEV Book Type"::Fiction, "DEV Book Status"::Available);
        CreateBook('To the Lighthouse', 'Modernist masterpiece', 'A landmark novel that explores consciousness, memory, and the passage of time through the Ramsay family.', "DEV Book Type"::Fiction, "DEV Book Status"::Available);
        CreateBook('The Old Man and the Sea', 'Tale of perseverance', 'An aging Cuban fisherman struggles with a giant marlin far out in the Gulf Stream.', "DEV Book Type"::Fiction, "DEV Book Status"::Available);
        CreateBook('Beloved', 'Powerful historical fiction', 'A former slave is haunted by the ghost of her daughter in post-Civil War Ohio.', "DEV Book Type"::Fiction, "DEV Book Status"::Available);
        CreateBook('Norwegian Wood', 'Coming-of-age story', 'A nostalgic story of loss and love set against the student protests in Tokyo in the late 1960s.', "DEV Book Type"::Fiction, "DEV Book Status"::Available);

        // Non-Fiction Books
        CreateBook('The Year of the Flood', 'Dystopian eco-fiction', 'The second book in the MaddAddam trilogy exploring environmental catastrophe and survival.', "DEV Book Type"::NonFiction, "DEV Book Status"::Available);
        CreateBook('Fire & Blood', 'Historical chronicle', 'The history of House Targaryen and their conquest of Westeros, centuries before Game of Thrones.', "DEV Book Type"::NonFiction, "DEV Book Status"::Available);
        CreateBook('The Casual Vacancy', 'Social commentary', 'A novel about a small English town in turmoil after a parish councillor dies unexpectedly.', "DEV Book Type"::NonFiction, "DEV Book Status"::Available);
        CreateBook('On Writing: A Memoir', 'Writing guide', 'Part memoir, part master class, offering insights into the craft of writing and the life of a writer.', "DEV Book Type"::NonFiction, "DEV Book Status"::Available);
        CreateBook('An Autobiography', 'Life story', 'Agatha Christie''s fascinating account of her life, loves, and the creation of her mysteries.', "DEV Book Type"::NonFiction, "DEV Book Status"::Unavailable);
        CreateBook('I, Robot', 'Robot ethics exploration', 'A collection of stories exploring the Three Laws of Robotics and their implications.', "DEV Book Type"::NonFiction, "DEV Book Status"::Available);
        CreateBook('A Room of One''s Own', 'Feminist essay', 'An extended essay arguing that a woman must have money and a room of her own to write fiction.', "DEV Book Type"::NonFiction, "DEV Book Status"::Available);
        CreateBook('A Moveable Feast', 'Memoir of Paris', 'Hemingway''s memoir of his years as a struggling writer in Paris during the 1920s.', "DEV Book Type"::NonFiction, "DEV Book Status"::Available);
        CreateBook('The Source of Self-Regard', 'Essay collection', 'Selected essays, speeches, and meditations spanning four decades of Toni Morrison''s career.', "DEV Book Type"::NonFiction, "DEV Book Status"::Available);
        CreateBook('Underground', 'Journalistic account', 'Murakami''s investigation into the 1995 Tokyo subway sarin gas attack through survivor interviews.', "DEV Book Type"::NonFiction, "DEV Book Status"::Unavailable);
    end;

    local procedure CreateNoSeries(NoSeriesCode: Code[20]; StartingNo: Code[20])
    var
        NoSeriesRec: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
    begin
        if not NoSeriesRec.Get(NoSeriesCode) then begin
            NoSeriesRec.Init();
            NoSeriesRec.Validate(Code, NoSeriesCode);
            NoSeriesRec.Validate(Description, NoSeriesCode);
            NoSeriesRec.Validate("Default Nos.", true);
            NoSeriesRec.Validate("Manual Nos.", true);
            NoSeriesRec.Insert(true);
        end;

        if not NoSeriesLine.Get(NoSeriesCode, 10000) then begin
            NoSeriesLine.Init();
            NoSeriesLine.Validate("Series Code", NoSeriesCode);
            NoSeriesLine.Validate("Line No.", 10000);
            NoSeriesLine.Validate("Starting No.", StartingNo);
            NoSeriesLine.Validate("Ending No.", '');
            NoSeriesLine.Validate("Increment-by No.", 1);
            NoSeriesLine.Insert(true);
        end;
    end;

    local procedure CreateNumbering()
    var
        ResourcesSetup: Record "Resources Setup";
    begin
        CreateNoSeries('AUTHOR', 'A00001');
        CreateNoSeries('BOOK', 'B00001');
        CreateNoSeries('RENTAL', 'R00001');
        ResourcesSetup.Get();
        ResourcesSetup.Validate("DEV Author Nos.", 'AUTHOR');
        ResourcesSetup.Validate("DEV Book Nos.", 'BOOK');
        ResourcesSetup.Validate("DEV Rental Nos.", 'RENTAL');
        ResourcesSetup.Modify(true);
    end;

    local procedure DemoDataAlreadyExists(): Boolean
    var
        Author: Record "DEV Author";
        Book: Record "DEV Book";
    begin
        exit(Author.FindFirst() and Book.FindFirst());
    end;
}