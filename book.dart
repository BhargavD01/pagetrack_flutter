class Book {
  final String id;
  final String title;
  final String author;
  final String category;
  final String description;
  final String isbn;
  final int year;
  final int pages;
  final String coverUrl;
  bool isIssued;
  DateTime? dueDate;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.isbn,
    required this.year,
    required this.pages,
    required this.coverUrl,
    this.isIssued = false,
    this.dueDate,
  });

  bool get isOverdue =>
      isIssued && dueDate != null && dueDate!.isBefore(DateTime.now());

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'author': author,
        'category': category,
        'description': description,
        'isbn': isbn,
        'year': year,
        'pages': pages,
        'coverUrl': coverUrl,
        'isIssued': isIssued,
        'dueDate': dueDate?.toIso8601String(),
      };

  factory Book.fromMap(Map<String, dynamic> map) => Book(
        id: map['id'] as String,
        title: map['title'] as String,
        author: map['author'] as String,
        category: map['category'] as String? ?? 'General',
        description: map['description'] as String? ?? '',
        isbn: map['isbn'] as String? ?? '',
        year: map['year'] as int? ?? 2020,
        pages: map['pages'] as int? ?? 200,
        coverUrl: map['coverUrl'] as String? ?? '',
        isIssued: map['isIssued'] as bool? ?? false,
        dueDate: map['dueDate'] == null
            ? null
            : DateTime.tryParse(map['dueDate'] as String),
      );
}
