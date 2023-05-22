import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ByAuthorScreen extends StatefulWidget {
  @override
  ByAuthorScreenState createState() => ByAuthorScreenState();
}

class ByAuthorScreenState extends State<ByAuthorScreen> {
  
  List<String> authors = [];

  @override
  void initState(){
    super.initState();
    fetchAuthors();
  }

   Future<void> fetchAuthors() async {
    
    final response = await http.get(Uri.parse('/authors'));

    if (response.statusCode == 200) {
      // Success
      setState(() {
        authors = List<String>.from(json.decode(response.body));
      });
    } else {
      // Failure
      throw Exception('Error! Could not load authors from API.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authors'),
      ),
      body: ListView.builder(
        itemCount: authors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(authors[index]),
          );
        },
      ),
    );
  }

}