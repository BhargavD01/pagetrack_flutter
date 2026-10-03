import 'package:flutter/material.dart';
import '../models/book.dart';

class IssuedBooksScreen extends StatelessWidget {
  final List<Book> books;
  final Future<void> Function(Book book) onReturn;
  final ValueChanged<Book> onOpenDetails;

  const IssuedBooksScreen({
    super.key,
    required this.books,
    required this.onReturn,
    required this.onOpenDetails,
  });

  String _date(DateTime d) => '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/${d.year}';

  @override
  Widget build(BuildContext context) {
    final overdue = books.where((b) => b.isOverdue).length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 35),
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 800;
            return Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color(0xFF172033),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'YOUR READING DESK',
                          style: TextStyle(
                            color: Color(0xFFE8B86D),
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 9),
                        const Text(
                          'Books currently on your desk.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          books.isEmpty
                              ? 'Your issued titles will appear here.'
                              : '$overdue overdue • ${books.length} active loan${books.length == 1 ? '' : 's'}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  if (wide)
                    const Icon(
                      Icons.bookmark_added_outlined,
                      color: Color(0x45FFFFFF),
                      size: 90,
                    ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        if (books.isEmpty)
          _empty()
        else
          ...books.map((book) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _LoanCard(
                  book: book,
                  due: _date(book.dueDate!),
                  onReturn: () => onReturn(book),
                  onTap: () => onOpenDetails(book),
                ),
              )),
      ],
    );
  }

  Widget _empty() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: const Color(0xFFE8E4DC)),
      ),
      child: const Column(
        children: [
          Icon(Icons.auto_stories_outlined, size: 60, color: Color(0xFF65738A)),
          SizedBox(height: 18),
          Text(
            'Your shelf is waiting.',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Color(0xFF172033),
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Issue a book from Discover and it will show up here.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF7B8290)),
          ),
        ],
      ),
    );
  }
}

class _LoanCard extends StatelessWidget {
  final Book book;
  final String due;
  final VoidCallback onReturn;
  final VoidCallback onTap;

  const _LoanCard({
    required this.book,
    required this.due,
    required this.onReturn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final overdue = book.isOverdue;
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: SizedBox(
                  width: 66,
                  height: 92,
                  child: Image.network(
                    book.coverUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const ColoredBox(
                      color: Color(0xFFE7EAF0),
                      child: Icon(Icons.menu_book),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: Color(0xFF172033),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.author,
                      style: const TextStyle(color: Color(0xFF747B88)),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          overdue ? Icons.warning_amber : Icons.event_outlined,
                          size: 17,
                          color: overdue
                              ? const Color(0xFFA4453D)
                              : const Color(0xFF52627C),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          overdue ? 'Overdue • Due $due' : 'Due $due',
                          style: TextStyle(
                            color: overdue
                                ? const Color(0xFFA4453D)
                                : const Color(0xFF52627C),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onReturn,
                child: const Text('Return'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
