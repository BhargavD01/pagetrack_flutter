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

How to Run

Make sure Flutter is installed and configured.

Run the following commands from the project directory:

flutter pub get
flutter analyze
flutter run -d chrome

The application can also be configured for other supported Flutter platforms.

⸻


Conclusion

PageTrack provides a complete digital library workflow from searching for a book → viewing its details → issuing the book → tracking the due date → returning the book.

The application combines Flutter UI development, Dart programming concepts, responsive design, and local storage into a single offline-capable library management experience.

screenshots

<img width="1466" height="835" alt="Screenshot 2026-10-03 at 1 57 49 AM" src="https://github.com/user-attachments/assets/91c51833-1a6a-4a73-9cd8-263818be5caa" />
<img width="1469" height="832" alt="Screenshot 2026-10-03 at 1 58 00 AM" src="https://github.com/user-attachments/assets/69266363-fd43-43e3-a395-37c39ce98ca2" />
<img width="1470" height="837" alt="Screenshot 2026-10-03 at 1 58 08 AM" src="https://github.com/user-attachments/assets/0831ff55-ef6f-4330-8cd9-06eb45e4c1a3" />
<img width="1470" height="831" alt="Screenshot 2026-10-03 at 1 58 24 AM" src="https://github.com/user-attachments/assets/79e08bec-03a7-4bf0-995d-606815c984b0" />
<img width="1470" height="836" alt="Screenshot 2026-10-03 at 1 58 32 AM" src="https://github.com/user-attachments/assets/f816c0a4-dedb-431d-ae7a-089461b267dc" />
<img width="699" height="618" alt="Screenshot 2026-10-03 at 2 31 01 AM" src="https://github.com/user-attachments/assets/f3b2a7b2-34b6-4d82-92a9-16f624d8a160" />
