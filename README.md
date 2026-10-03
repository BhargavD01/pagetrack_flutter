# PageTrack — Premium Digital Library App

A polished Flutter Material 3 prototype for a college library.

## Requirements covered

### UI / Widgets
- Catalog discovery screen
- Responsive GridView of books
- Card-based book catalogue
- Search by title, author, category
- Book detail screen
- My Issued Books screen using ListView
- Real book cover images
- Availability badges
- Due dates and overdue warning states
- Animated navigation between primary sections

### Styling / Theming
- Material 3
- Premium library-inspired navy / cream / gold visual system
- Responsive desktop/tablet/mobile navigation
- Hover treatment for book cards on web
- Consistent cards, chips, badges and CTA styling

### Dart logic
- `Book` model class
- Encapsulated fields/state
- `List<Book>` catalogue
- computed `isOverdue` getter
- JSON serialization with `Map<String, dynamic>`
- async/await

### Local storage
- SharedPreferences
- JSON encoding/decoding
- Issue / return state survives reloads

## Image source

Book covers are displayed using Open Library's Covers API with ISBN-based URLs.

Open Library documents the public cover URL format:
https://covers.openlibrary.org/b/isbn/<ISBN>-L.jpg

Open Library recommends using the cover URLs directly for public-facing pages and appreciates a courtesy link back to Open Library.

```

## Exam demo flow

1. Open Discover.
2. Show responsive catalog and real covers.
3. Search for a title or author.
4. Filter by category.
5. Open a book.
6. Explain metadata and availability.
7. Issue the book.
8. Return to My Books.
9. Show due date.
10. Return the book.
11. Reload the application and demonstrate that state is persisted locally.

## Architecture

`main.dart`
→ Material 3 application theme

`library_shell.dart`
→ application navigation, search state, issue/return actions

`catalog_screen.dart`
→ responsive catalogue and search/filter UI

`book_detail_screen.dart`
→ detailed book view and issue/return CTA

`issued_books_screen.dart`
→ active loans and overdue states

`book.dart`
→ model and serialization

`storage_service.dart`
→ SharedPreferences persistence and seed catalogue
