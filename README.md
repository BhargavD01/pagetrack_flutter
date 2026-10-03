PageTrack — Digital Library Book Issue & Return App

Problem Statement

College libraries often require students to manually search for books, check their availability, keep track of issued books, and remember return dates. This can make the process inconvenient and difficult to manage.

PageTrack is a Flutter-based digital library application designed to provide a simple and responsive way for students to browse a library catalog, search for books, issue available books, track due dates, and return issued books.

The application also stores catalog and issue information locally so that the data remains available between app sessions.

⸻

Project Functionality

PageTrack provides the following core functionality:

1. Book Catalog

The application displays a collection of library books containing:

* Book title
* Author
* Category
* Availability status
* Book cover
* Description
* ISBN
* Publication year
* Number of pages

Books are displayed using responsive cards in a GridView.

2. Search & Filtering

Users can:

* Search books by title
* Search books by author
* Filter books by category
* View the number of matching results

The catalog updates dynamically as the user searches or changes the selected category.

3. Book Details

Selecting a book opens a dedicated Book Details screen containing:

* Book cover
* Title
* Author
* Description
* Category
* Publication year
* Number of pages
* ISBN
* Current availability
* Issue/Return action

4. Issue a Book

When an available book is issued:

Available → Issued

The application:

* Updates the book’s availability
* Generates a due date
* Updates the catalog immediately
* Adds the book to My Issued Books
* Saves the updated information locally

The default loan period is 14 days.

5. My Issued Books

The My Issued Books section displays all currently issued books.

Users can see:

* Book title
* Author
* Cover
* Due date
* Overdue status
* Return button

6. Overdue Detection

The application automatically compares the book’s due date with the current date.

If the due date has passed, the book is marked as Overdue.

7. Return a Book

When a user returns a book:

Issued → Available

The application:

* Removes the issued status
* Clears the due date
* Updates the catalog
* Removes the book from My Issued Books
* Saves the updated data locally

8. Local Data Storage

PageTrack uses SharedPreferences for local persistence.

Book information is converted into maps and JSON before being stored locally.

When the application starts again, the saved data is loaded and reconstructed into Book objects.

This allows the application to retain issue and return information between sessions.

⸻

Main Screens

The application contains three primary user flows:

1. Catalog
    * Browse books
    * Search and filter
    * View availability
2. Book Details
    * View complete book information
    * Issue or return a book
3. My Issued Books
    * View currently issued books
    * Track due dates
    * Identify overdue books
    * Return books

⸻

Technology Used

* Flutter
* Dart
* Material 3
* SharedPreferences
* JSON serialization
* Responsive Flutter layouts

⸻

Project Architecture

PageTrack
│
├── UI Layer
│   ├── Catalog
│   ├── Book Details
│   └── My Issued Books
│
├── Data Model
│   └── Book
│
└── Data Layer
    └── StorageService
        └── SharedPreferences

Application Flow

Book Model
     ↓
List<Book>
     ↓
LibraryShell
     ↓
Catalog / Book Details / My Issued Books
     ↓
Issue / Return
     ↓
setState()
     ↓
StorageService
     ↓
SharedPreferences

⸻

Project Objective

The main objective of PageTrack is to demonstrate the practical use of:

* Flutter widgets and responsive layouts
* Material 3 design
* Dart classes and object-oriented programming
* Lists and Maps
* Stateful and Stateless widgets
* Navigation between screens
* Form-free interactive UI flows
* Local data persistence
* JSON-based data serialization
* Search and filtering
* Real-time UI updates using setState()

⸻

Conclusion

PageTrack provides a complete digital library workflow from searching for a book → viewing its details → issuing the book → tracking the due date → returning the book.

The application combines Flutter UI development, Dart programming concepts, responsive design, and local storage into a single offline-capable library management experience.

Screenshots

<img width="2932" height="1670" alt="image" src="https://github.com/user-attachments/assets/58c48145-d465-41a1-ab1f-cd57474c6f9d" />
<img width="2938" height="1664" alt="image" src="https://github.com/user-attachments/assets/3f9f2447-955b-4800-b96c-acf96e091743" />
<img width="2940" height="1674" alt="image" src="https://github.com/user-attachments/assets/cfe25c85-0338-45ea-9ed8-d7709e6f2be5" />
<img width="2940" height="1672" alt="image" src="https://github.com/user-attachments/assets/a91d78dd-f1c2-456c-b25d-036154462982" />
<img width="2934" height="1656" alt="image" src="https://github.com/user-attachments/assets/c41d0f88-2707-406c-9956-b81af8ac860c" />
<img width="2940" height="1662" alt="image" src="https://github.com/user-attachments/assets/95f333eb-38e1-4910-8d27-ed9dda2b6db2" />
<img width="1398" height="1236" alt="image" src="https://github.com/user-attachments/assets/5a6f7025-b20c-448d-b685-891e9557da83" />

Thank You.
