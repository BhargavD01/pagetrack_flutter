import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book.dart';

class StorageService {
  static const _key = 'pagetrack_catalog_v2';

  Future<List<Book>> loadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return _seedBooks();

    try {
      final data = jsonDecode(raw) as List<dynamic>;
      return data
          .map((e) => Book.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (_) {
      return _seedBooks();
    }
  }

  Future<void> saveBooks(List<Book> books) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(books.map((b) => b.toMap()).toList()),
    );
  }

  List<Book> _seedBooks() => [
        Book(
          id: 'PT-001',
          title: 'The Alchemist',
          author: 'Paulo Coelho',
          category: 'Fiction',
          description:
              'A philosophical novel about following a dream, listening to intuition, and finding meaning through a journey.',
          isbn: '9780062315007',
          year: 2014,
          pages: 208,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9780062315007-L.jpg',
        ),
        Book(
          id: 'PT-002',
          title: 'Atomic Habits',
          author: 'James Clear',
          category: 'Self Development',
          description:
              'A practical framework for building good habits, breaking bad ones, and improving through small, consistent changes.',
          isbn: '9780735211292',
          year: 2018,
          pages: 320,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9780735211292-L.jpg',
        ),
        Book(
          id: 'PT-003',
          title: 'Clean Code',
          author: 'Robert C. Martin',
          category: 'Computer Science',
          description:
              'A software craftsmanship guide covering readable code, naming, functions, objects, testing, and maintainable design.',
          isbn: '9780132350884',
          year: 2008,
          pages: 464,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9780132350884-L.jpg',
        ),
        Book(
          id: 'PT-004',
          title: 'The Pragmatic Programmer',
          author: 'David Thomas & Andrew Hunt',
          category: 'Computer Science',
          description:
              'Classic advice on software development, professional habits, debugging, architecture, and long-term craftsmanship.',
          isbn: '9780135957059',
          year: 2019,
          pages: 352,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9780135957059-L.jpg',
        ),
        Book(
          id: 'PT-005',
          title: 'Flutter in Action',
          author: 'Eric Windmill',
          category: 'Mobile Development',
          description:
              'A practical introduction to building beautiful cross-platform applications with Flutter and Dart.',
          isbn: '9781617296142',
          year: 2020,
          pages: 288,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9781617296142-L.jpg',
        ),
        Book(
          id: 'PT-006',
          title: 'Dart Apprentice',
          author: 'Ray Wenderlich Team',
          category: 'Programming',
          description:
              'A hands-on guide to Dart fundamentals, object-oriented programming, collections, and modern language features.',
          isbn: '9781950325219',
          year: 2020,
          pages: 450,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9781950325219-L.jpg',
        ),
        Book(
          id: 'PT-007',
          title: 'Deep Work',
          author: 'Cal Newport',
          category: 'Productivity',
          description:
              'A guide to focused work in a distracted world and the value of cultivating sustained concentration.',
          isbn: '9781455586691',
          year: 2016,
          pages: 304,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9781455586691-L.jpg',
        ),
        Book(
          id: 'PT-008',
          title: 'Design Patterns',
          author: 'Erich Gamma et al.',
          category: 'Computer Science',
          description:
              'A foundational reference for reusable object-oriented software design patterns and principles.',
          isbn: '9780201633610',
          year: 1994,
          pages: 416,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9780201633610-L.jpg',
        ),
        Book(
          id: 'PT-009',
          title: 'Introduction to Algorithms',
          author: 'Thomas H. Cormen et al.',
          category: 'Computer Science',
          description:
              'A comprehensive algorithms reference covering sorting, graph algorithms, data structures, optimization, and more.',
          isbn: '9780262046305',
          year: 2022,
          pages: 1312,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9780262046305-L.jpg',
        ),
        Book(
          id: 'PT-010',
          title: 'Think Like a Monk',
          author: 'Jay Shetty',
          category: 'Personal Growth',
          description:
              'Lessons and exercises inspired by monastic practice for reducing distraction and building purpose.',
          isbn: '9781982134488',
          year: 2020,
          pages: 352,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9781982134488-L.jpg',
        ),
        Book(
          id: 'PT-011',
          title: 'The Psychology of Money',
          author: 'Morgan Housel',
          category: 'Finance',
          description:
              'Timeless lessons about behavior, risk, wealth, and the ways people think about money.',
          isbn: '9780857197689',
          year: 2020,
          pages: 256,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9780857197689-L.jpg',
        ),
        Book(
          id: 'PT-012',
          title: 'Sapiens',
          author: 'Yuval Noah Harari',
          category: 'History',
          description:
              'A sweeping narrative of human history from early hunter-gatherers to modern societies.',
          isbn: '9780062316097',
          year: 2015,
          pages: 464,
          coverUrl:
              'https://covers.openlibrary.org/b/isbn/9780062316097-L.jpg',
        ),
      ];
}
