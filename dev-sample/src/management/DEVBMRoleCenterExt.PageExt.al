namespace SummitNA.BookManagement.Management;

using Microsoft.Finance.RoleCenters;
using SummitNA.BookManagement.Book;
using SummitNA.BookManagement.Author;
using SummitNA.BookManagement.Rental;
using Microsoft.Projects.Resources.Setup;

pageextension 50102 "DEV BM Role Center Ext" extends "Business Manager Role Center"
{
    actions
    {
        addfirst(sections)
        {
            group(DEVBooksManagement)
            {
                Caption = 'Books Management';

                action(DEVAuthors)
                {
                    ApplicationArea = All;
                    Caption = 'Manage Authors';
                    Image = Card;
                    ToolTip = 'View and manage your library''s author database. Add new authors, update biographical information, and track their published works.';
                    RunObject = page "DEV Author List";
                }
                action(DEVBooks)
                {
                    ApplicationArea = All;
                    Caption = 'Manage Books';
                    Image = Card;
                    ToolTip = 'Access your complete book catalog. Add new titles, edit book details, track inventory status, and link books to their authors.';
                    RunObject = page "DEV Book List";
                }
                action(DEVRentals)
                {
                    ApplicationArea = All;
                    Caption = 'Manage Rentals';
                    Image = Card;
                    ToolTip = 'Monitor and manage book rentals. Create new rental transactions, track due dates, process returns, and view rental history for customers.';
                    RunObject = page "DEV Book Rental List";
                }
                action(DEVResourcesSetup)
                {
                    ApplicationArea = All;
                    Caption = 'Resources Setup';
                    Image = Setup;
                    ToolTip = 'Set up and configure resource management settings. Define resource categories, availability, and allocation rules to optimize resource utilization.';
                    RunObject = page "Resources Setup";
                }
            }
        }
    }
}
