import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

List<Book> booksFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String booksToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  int? id;
  String title;
  String author;
  String summary;
  String genre;
  String? img;
  int npages;
  int year;
  int qty;

  Book({
    required this.title,
    required this.author,
    required this.summary,
    required this.genre,
    required this.img,
    required this.npages,
    required this.year,
    required this.qty,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"],
        author: json["author"],
        summary: json["summary"],
        genre: json["genre"],
        img: json["img"],
        npages: json["npages"],
        year: json["year"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "summary": summary,
        "genre": genre,
        "img": img,
        "npages": npages,
        "year": year,
        "qty": qty,
      };
}
