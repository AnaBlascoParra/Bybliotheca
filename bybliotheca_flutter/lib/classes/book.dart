class Book {
  int id;
  String title;
  String author;
  String genre;
  int npages;
  int year;
  int qty;

  Book({
    this.id,
    this.title,
    this.author,
    this.genre,
    this.npages,
    this.year,
    this.qty,
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
