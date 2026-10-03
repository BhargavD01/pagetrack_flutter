import 'package:flutter/material.dart';
import '../models/book.dart';

class CatalogScreen extends StatelessWidget {
  final List<Book> books;
  final int totalBooks;
  final int issuedCount;
  final TextEditingController searchController;
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<Book> onBookTap;

  const CatalogScreen({
    super.key,
    required this.books,
    required this.totalBooks,
    required this.issuedCount,
    required this.searchController,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;
        final columns = constraints.maxWidth >= 1250
            ? 5
            : constraints.maxWidth >= 900
                ? 4
                : constraints.maxWidth >= 600
                    ? 3
                    : 2;

        return ListView(
          padding: EdgeInsets.fromLTRB(wide ? 34 : 20, 10, wide ? 34 : 20, 30),
          children: [
            if (!wide)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search books, authors...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            _hero(context, wide),
            const SizedBox(height: 26),
            Row(
              children: [
                _stat(context, Icons.menu_book_outlined, '$totalBooks', 'Books'),
                const SizedBox(width: 12),
                _stat(context, Icons.bookmark_outline, '$issuedCount', 'On loan'),
                const SizedBox(width: 12),
                _stat(
                  context,
                  Icons.check_circle_outline,
                  '${totalBooks - issuedCount}',
                  'Available',
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Browse by category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF172033),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final value = categories[i];
                  return ChoiceChip(
                    label: Text(value),
                    selected: selectedCategory == value,
                    onSelected: (_) => onCategoryChanged(value),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: selectedCategory == value
                          ? const Color(0xFF1F3154)
                          : const Color(0xFF687080),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                const Text(
                  'All titles',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF172033),
                  ),
                ),
                const Spacer(),
                Text(
                  '${books.length} results',
                  style: const TextStyle(color: Color(0xFF7B8290)),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (books.isEmpty)
              _empty(context)
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: .63,
                ),
                itemBuilder: (_, i) => _BookCard(
                  book: books[i],
                  onTap: () => onBookTap(books[i]),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _hero(BuildContext context, bool wide) {
    return Container(
      constraints: const BoxConstraints(minHeight: 235),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF172033), Color(0xFF2E466D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 30,
            offset: Offset(0, 16),
            color: Color(0x18172033),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -50,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white12, width: 25),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(wide ? 34 : 25),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8B86D),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'CAMPUS LIBRARY',
                          style: TextStyle(
                            color: Color(0xFF172033),
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'A quieter place for better ideas.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: wide ? 34 : 28,
                          height: 1.08,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Search the collection, check availability,and borrow a title in seconds.',
                        style: TextStyle(
                          color: Colors.white70,
                          height: 1.45,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (wide)
                  const SizedBox(
                    width: 160,
                    child: Icon(
                      Icons.auto_stories_rounded,
                      size: 130,
                      color: Color(0x35FFFFFF),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(BuildContext context, IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8E4DC)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF2E466D)),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Color(0xFF172033),
                    ),
                  ),
                  Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7B8290),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _empty(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE8E4DC)),
      ),
      child: const Column(
        children: [
          Icon(Icons.menu_book_outlined, size: 52, color: Color(0xFF87909E)),
          SizedBox(height: 14),
          Text(
            'No titles match your search.',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 5),
          Text(
            'Try another title, author or category.',
            style: TextStyle(color: Color(0xFF7B8290)),
          ),
        ],
      ),
    );
  }
}

class _BookCard extends StatefulWidget {
  final Book book;
  final VoidCallback onTap;

  const _BookCard({required this.book, required this.onTap});

  @override
  State<_BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<_BookCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final available = !book.isIssued;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(0, hover ? -5 : 0, 0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              book.coverUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFFE7EAF0),
                                child: const Icon(
                                  Icons.menu_book,
                                  size: 45,
                                  color: Color(0xFF51627E),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 9,
                          left: 9,
                          child: _Badge(
                            label: available ? 'AVAILABLE' : 'ISSUED',
                            available: available,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF172033),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF747B88),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.category,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF53657F),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final bool available;

  const _Badge({required this.label, required this.available});

  @override
  Widget build(BuildContext context) {
    final bg = available ? const Color(0xE8F1F7EF) : const Color(0xFFF8ECEB);
    final fg = available ? const Color(0xFF2D6944) : const Color(0xFF9B443D);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: .6,
        ),
      ),
    );
  }
}
