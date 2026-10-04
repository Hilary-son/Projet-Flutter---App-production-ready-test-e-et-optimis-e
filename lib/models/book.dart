class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.totalPages,
    this.currentPage = 0,
    this.coverUrl,
  });

  final String id;
  final String title;
  final String author;
  final int totalPages;
  final int currentPage;
  final String? coverUrl;

  double get progress => totalPages == 0 ? 0 : currentPage / totalPages;

  bool get isFinished => totalPages > 0 && currentPage >= totalPages;

  Book copyWith({int? currentPage}) {
    return Book(
      id: id,
      title: title,
      author: author,
      totalPages: totalPages,
      currentPage: currentPage ?? this.currentPage,
      coverUrl: coverUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'totalPages': totalPages,
        'currentPage': currentPage,
        'coverUrl': coverUrl,
      };

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      totalPages: json['totalPages'] as int,
      currentPage: json['currentPage'] as int? ?? 0,
      coverUrl: json['coverUrl'] as String?,
    );
  }
}
