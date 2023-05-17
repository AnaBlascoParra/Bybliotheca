import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListBooks extends StatefulWidget{
  @override
_ListBooksState createState() => _ListBooksState();
}

class _ListBooksState extends State<ListBooks>{
  List data;

  Future<List> getData() async {
    final response = await http.get("http://192.168.1.38:8080/books");
    return json.decode(response.body);
  }

@override void initState(){
  this.getData();
}

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(
      title: Text('All books'),
      actions: ,)
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
          ? ItemList(
            list: snapshot.data,
          )
          : Center(
            child: CircularProgressIndicator(),
          )
        }),
    );   
  }
}

class ItemList extends StatelessWidget{
  final List list;

  const ItemList({this.list});

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context,i) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  height: 100.3,
                  child: Card(
                    color: Colors.beigeertifica
                  )
                )
              )
            )
          ]
        )
      }
    );
  }

}