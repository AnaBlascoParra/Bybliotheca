import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:bybliotheca_flutter/models/models.dart';
import '../services/services.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final formKey = GlobalKey<FormState>();
  final book = Book(
      title: '',
      author: '',
      summary: '',
      genre: '',
      npages: 0,
      year: 0,
      qty: 0);
  final background = const AssetImage("assets/background.png");

  addbook() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final url = 'http://localhost:8080/addBook';
      String? token = await UserService().readToken();
      final body = jsonEncode(book.toJson());

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": token!
        },
        body: jsonEncode(book.toJson()),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/mainmenu');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add book',style: TextStyle(fontFamily:'Enchanted Land')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/mainmenu');
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: background,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    onSaved: (value) => book.title = value!,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    onSaved: (value) => book.author = value!,
                    decoration: const InputDecoration(
                      labelText: 'Author',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    onSaved: (value) => book.summary = value!,
                    decoration: const InputDecoration(
                      labelText: 'Summary',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => book.genre = value!,
                    decoration: const InputDecoration(
                      labelText: 'Genre',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    onSaved: (value) => book.npages = int.parse(value!),
                    decoration: const InputDecoration(
                      labelText: 'Number of pages',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    onSaved: (value) => book.year = int.parse(value!),
                    decoration: const InputDecoration(
                      labelText: 'Publication year',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    onSaved: (value) => book.qty = int.parse(value!),
                    decoration: const InputDecoration(
                      labelText: 'Stock',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 48, 25, 6)),
                      ),
                      child: Text('Add'),
                      onPressed: () {
                        addbook();
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
