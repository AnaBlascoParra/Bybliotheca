class Book {
  int id;
  String title;
  String author;
  String genre;
  int npages;
  int year;
  int qty;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.npages,
    required this.year,
    required this.qty,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      npages: json['npages'],
      year: json['year'],
      qty: json['qty'],
    );
  }
}