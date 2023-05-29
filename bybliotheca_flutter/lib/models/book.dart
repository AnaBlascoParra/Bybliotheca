import 'dart:convert';

Book bookJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  int? id;
  String title;
  String author;
  String summary;
  String genre;
  int npages;
  int year;
  int qty;

  Book(
      {required this.title,
      required this.author,
      required this.summary,
      required this.genre,
      required this.npages,
      required this.year,
      required this.qty});

  factory Book.fromJson(Map<String, dynamic> json) => Book(
      title: json['title'],
      author: json['author'],
      summary: json['summary'],
      genre: json['genre'],
      npages: json['npages'],
      year: json['year'],
      qty: json['qty']);

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "summary": summary,
        "genre": genre,
        "npages": npages,
        "year": year,
        "qty": qty
      };
}
