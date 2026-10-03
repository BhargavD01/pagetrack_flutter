import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/storage_service.dart';
import 'catalog_screen.dart';
import 'book_detail_screen.dart';
import 'issued_books_screen.dart';

class LibraryShell extends StatefulWidget {
  const LibraryShell({super.key});

  @override
  State<LibraryShell> createState() => _LibraryShellState();
}

class _LibraryShellState extends State<LibraryShell> {
  final StorageService _storage = StorageService();
  final TextEditingController _search = TextEditingController();

  List<Book> _books = [];
  bool _loading = true;
  int _section = 0;
  String _query = '';
  String _category = 'All';

  @override
  void initState() {
    super.initState();
    _search.addListener(() {
      setState(() => _query = _search.text.trim().toLowerCase());
    });
    _load();
  }

  Future<void> _load() async {
    final books = await _storage.loadBooks();
    if (!mounted) return;
    setState(() {
      _books = books;
      _loading = false;
    });
  }

  Future<void> _persist() => _storage.saveBooks(_books);

  List<Book> get _issued => _books.where((b) => b.isIssued).toList();

  List<String> get _categories {
    final values = _books.map((b) => b.category).toSet().toList()..sort();
    return ['All', ...values];
  }

  List<Book> get _filtered {
    return _books.where((book) {
      final text = '${book.title} ${book.author} ${book.category}'.toLowerCase();
      return (_query.isEmpty || text.contains(_query)) &&
          (_category == 'All' || book.category == _category);
    }).toList();
  }

  Future<void> _issue(Book book) async {
    setState(() {
      book.isIssued = true;
      book.dueDate = DateTime.now().add(const Duration(days: 14));
    });
    await _persist();
    if (!mounted) return;
    _toast('${book.title} added to your issued books.');
  }

  Future<void> _return(Book book) async {
    setState(() {
      book.isIssued = false;
      book.dueDate = null;
    });
    await _persist();
    if (!mounted) return;
    _toast('${book.title} has been returned.');
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message),
          action: SnackBarAction(label: 'OK', onPressed: () {}),
        ),
      );
  }

  void _openBook(Book book) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BookDetailScreen(
          book: book,
          onIssue: () => _issue(book),
          onReturn: () => _return(book),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final wide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (wide) _sideRail(),
            Expanded(
              child: Column(
                children: [
                  _topBar(wide),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 280),
                      child: _section == 0
                          ? CatalogScreen(
                              key: const ValueKey('catalog'),
                              books: _filtered,
                              totalBooks: _books.length,
                              issuedCount: _issued.length,
                              searchController: _search,
                              categories: _categories,
                              selectedCategory: _category,
                              onCategoryChanged: (v) =>
                                  setState(() => _category = v),
                              onBookTap: _openBook,
                            )
                          : IssuedBooksScreen(
                              key: const ValueKey('issued'),
                              books: _issued,
                              onReturn: _return,
                              onOpenDetails: _openBook,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: _section,
              onDestinationSelected: (v) => setState(() => _section = v),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore),
                  label: 'Discover',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bookmark_outline),
                  selectedIcon: Icon(Icons.bookmark),
                  label: 'My Books',
                ),
              ],
            ),
    );
  }

  Widget _sideRail() {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: Color(0xFF172033),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8B86D),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(Icons.auto_stories, color: Color(0xFF172033)),
                ),
                const SizedBox(width: 12),
                const Text(
                  'PageTrack',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          _navItem(0, Icons.explore_outlined, 'Discover'),
          _navItem(1, Icons.bookmark_outline, 'My Issued Books'),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(18),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .07),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(Icons.wifi_off_outlined, color: Color(0xFFE8B86D)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Library data is saved on this device.',
                    style: TextStyle(color: Colors.white70, height: 1.35),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final active = _section == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => setState(() => _section = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: active ? Colors.white.withValues(alpha: .10) : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(icon, color: active ? const Color(0xFFE8B86D) : Colors.white60),
              const SizedBox(width: 13),
              Text(
                label,
                style: TextStyle(
                  color: active ? Colors.white : Colors.white60,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar(bool wide) {
    return Padding(
      padding: EdgeInsets.fromLTRB(wide ? 34 : 20, 24, wide ? 34 : 20, 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _section == 0 ? 'Library catalogue' : 'My reading desk',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF172033),
                        letterSpacing: -.7,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _section == 0
                      ? 'Discover your next great read.'
                      : 'Keep an eye on your active loans and due dates.',
                  style: const TextStyle(color: Color(0xFF747B88)),
                ),
              ],
            ),
          ),
          if (_section == 0 && wide)
            SizedBox(
              width: 300,
              child: TextField(
                controller: _search,
                decoration: const InputDecoration(
                  hintText: 'Search books, authors...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          const SizedBox(width: 14),
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFE6EAF1),
            child: const Icon(Icons.person_outline, color: Color(0xFF34425C)),
          ),
        ],
      ),
    );
  }
}
