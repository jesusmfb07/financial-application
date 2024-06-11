import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // final ThemeData theme = ThemeData(
    //   scaffoldBackgroundColor: Colors.blue,
    // );
    return MaterialApp(
      title: 'scaffoldApp',
      debugShowCheckedModeBanner: false,
      // theme:theme,
      home: MyHomePage(title: 'scaffold App Home'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  Icon _corazon = Icon(Icons.favorite_border, color:Colors.white);
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(widget.title!),
          actions: [
            IconButton(
                onPressed:_likedChange,
                icon: _corazon,
            )
          ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){_likedChange();},
        backgroundColor: Colors.red,
        icon: _corazon,
        label: Text('Like!'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.chat_bubble_outline_rounded,color:Colors.black),
                  // text:Text('Chats', style: TextStyle(color: Colors.black)),),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.insert_chart,color:Colors.black),
                // text:Text('Chats', style: TextStyle(color: Colors.black)),),
              ),

            ],
          )
        )

      ),
    );
  }
  void _likedChange(){
    setState(() {
      if(_liked){
        _corazon = Icon(Icons.favorite_border, color:Colors.white);
        _liked = false;
      }else{
        _corazon = Icon(Icons.favorite, color:Colors.red);
        _liked = true;
      }});

  }
}

