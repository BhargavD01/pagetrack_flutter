import 'package:flutter/material.dart';
import '../models/book.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  final VoidCallback onIssue;
  final VoidCallback onReturn;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.onIssue,
    required this.onReturn,
  });

  String _date(DateTime d) => '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/${d.year}';

  @override
  Widget build(BuildContext context) {
    final available = !book.isIssued;
    final overdue = book.isOverdue;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      appBar: AppBar(
        title: const Text(
          'Book details',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 850;

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              wide ? 70 : 20,
              24,
              wide ? 70 : 20,
              40,
            ),
            child: wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cover(context),
                      const SizedBox(width: 48),
                      Expanded(child: _details(context, overdue, available)),
                    ],
                  )
                : Column(
                    children: [
                      _cover(context),
                      const SizedBox(height: 28),
                      _details(context, overdue, available),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _cover(BuildContext context) {
    return Container(
      width: 280,
      height: 390,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A172033),
            blurRadius: 28,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Image.network(
          book.coverUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Center(
            child: Icon(Icons.menu_book, size: 80),
          ),
        ),
      ),
    );
  }

  Widget _details(BuildContext context, bool overdue, bool available) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.category.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF9A7040),
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            book.title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF172033),
                  letterSpacing: -1.4,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'by ${book.author}',
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF687080),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            book.description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.65,
              color: Color(0xFF4E5664),
            ),
          ),
          const SizedBox(height: 26),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _meta(Icons.calendar_today_outlined, 'Published ${book.year}'),
              _meta(Icons.menu_book_outlined, '${book.pages} pages'),
              _meta(Icons.qr_code_2, 'ISBN ${book.isbn}'),
            ],
          ),
          const SizedBox(height: 26),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: overdue
                  ? const Color(0xFFFFF2F0)
                  : available
                      ? const Color(0xFFF0F6F1)
                      : const Color(0xFFF2F4F8),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: overdue
                    ? const Color(0xFFF0C4BF)
                    : const Color(0xFFE0E4EA),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  overdue
                      ? Icons.warning_amber_rounded
                      : available
                          ? Icons.check_circle_outline
                          : Icons.schedule,
                  color: overdue
                      ? const Color(0xFFAA453D)
                      : available
                          ? const Color(0xFF35724B)
                          : const Color(0xFF52627C),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    overdue
                        ? 'This loan is overdue — please return it.'
                        : book.isIssued
                            ? 'Issued • Due ${_date(book.dueDate!)}'
                            : 'Available to issue today',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: available ? onIssue : onReturn,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF1F3154),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              icon: Icon(
                available ? Icons.bookmark_add_outlined : Icons.assignment_return_outlined,
              ),
              label: Text(
                available ? 'Issue this book' : 'Return this book',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _meta(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE2DED6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF53657F)),
          const SizedBox(width: 7),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF596271),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
