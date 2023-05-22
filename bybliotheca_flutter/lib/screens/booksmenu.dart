import 'package:flutter/material.dart';

class BooksMenuScreen extends StatelessWidget {
  const BooksMenuScreen({super.key});

  final _allbooks = const AssetImage("assets/allbooks.png");
  final _byauthor = const AssetImage("assets/byauthor.png");
  final _bygenre = const AssetImage("assets/bygenre.png");
  final _background = const AssetImage("assets/background.png");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: _background,
              fit: BoxFit.cover,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildButton(
                      image: _allbooks,
                      label: "All Books",
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/allbooks');
                      },
                    ),
                    SizedBox(height: 16),
                    buildButton(
                      image: _byauthor,
                      label: "Books by Author",
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/byauthor');
                      },
                    ),
                    SizedBox(height: 16),
                    buildButton(
                      image: _bygenre,
                      label: "Books by Genre",
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/bygenre');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton({
    required AssetImage image,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Text(
                label,
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
    );
  }
}
