import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ByGenreScreen extends StatefulWidget {
  @override
  ByGenreScreenState createState() => ByGenreScreenState();
}

class ByGenreScreenState extends State<ByGenreScreen> {
  
  List<String> genres = [];

  @override
  void initState(){
    super.initState();
    fetchGenres();
  }

   Future<void> fetchGenres() async {
    
    final response = await http.get(Uri.parse('/genres'));

    if (response.statusCode == 200) {
      // Success
      setState(() {
        genres = List<String>.from(json.decode(response.body));
      });
    } else {
      // Failure
      throw Exception('Error! Could not load genres from API.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genres'),
      ),
      body: ListView.builder(
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(genres[index]),
          );
        },
      ),
    );
  }

}