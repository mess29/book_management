class Book {
  String title;
  String author;
  String description;
  String notes;
  String genre;
  bool isRead;

  Book({
    required this.title,
    required this.author,
    this.description = '',
    this.notes = '',
    required this.genre,
    this.isRead = false,
  });
}
