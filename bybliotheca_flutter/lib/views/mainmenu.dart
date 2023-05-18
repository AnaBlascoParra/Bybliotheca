import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {

final _byauthor = new AssetImage("assets/byauthor.png");
final _bygenre = new AssetImage("assets/bygenre.png");

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bybliotheca'),
        ),
        body: GestureDetector(
          onTap:(){
           
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
                    "By Author",
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
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
              label: 'My Account',
              icon: Icon(Icons.account_box)
            )
          ],   
        ),
      ),
    );
  }

}


  