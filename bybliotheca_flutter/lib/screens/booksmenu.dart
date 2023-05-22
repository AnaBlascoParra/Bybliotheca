import 'package:flutter/material.dart';

class BooksMenuScreen extends StatelessWidget{
  const BooksMenuScreen({super.key});

  final _allbooks = const AssetImage("assets/allbooks.png");
  final _byauthor = const AssetImage("assets/byauthor.png");
  final _bygenre = const AssetImage("assets/bygenre.png");

  @override
    Widget build(BuildContext context) {

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Bybliotheca'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap:(){
                  Navigator.pushReplacementNamed(context, '/allbooks'); 
                },
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage("assets/_allbooks.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Positioned.fill(
                      child: Center(
                        child: Text(
                          "All Books",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap:(){
                  Navigator.pushReplacementNamed(context, '/byauthor'); 
                },
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage("assets/_byauthor.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Positioned.fill(
                      child: Center(
                        child: Text(
                          "Books by Author",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap:(){
                  Navigator.pushReplacementNamed(context, '/bygenre'); //ByGenreScreen()
                },
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage("assets/_bygenre.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Positioned.fill(
                      child: Center(
                        child: Text(
                          "Books by Genre",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      );
    }
}


  