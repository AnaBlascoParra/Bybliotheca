class Book {
  int id;
  String title;
  String author;
  String summary;
  String genre;
  int npages;
  int year;
  int qty;

  Book({
    this.id,
    this.title,
    this.author,
    this.summary,
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
      summary: json['summary'],
      genre: json['genre'],
      npages: json['npages'],
      year: json['year'],
      qty: json['qty'],
    );
  }
  
}