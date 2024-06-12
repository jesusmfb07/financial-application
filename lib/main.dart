import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'scaffoldApp',
      debugShowCheckedModeBanner: false,
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
  Icon _corazon = Icon(Icons.favorite_border, color: Colors.white);
  bool _liked = false;
  int _selectedIndex = 0;
  String textToDisplay = '0 : Home';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title!),
        actions: [
          IconButton(
            onPressed: _likedChange,
            icon: _corazon,
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: const [
            DrawerHeader(
              child: Text(
                'Menu Drawer',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                ),
              ),
            ),
            Text('Enlace 1'),
            Text('Enlace 2'),
            Text('Enlace 3'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textToDisplay,
              style: TextStyle(
                color: Colors.red,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _likedChange,
        backgroundColor: Colors.red,
        icon: _corazon,
        label: const Text('Like!'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Reportes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemPressed,
      ),
    );
  }

  void _likedChange() {
    setState(() {
      if (_liked) {
        _corazon = Icon(Icons.favorite_border, color: Colors.white);
        _liked = false;
      } else {
        _corazon = Icon(Icons.favorite, color: Colors.red);
        _liked = true;
      }
    });
  }

  void _onItemPressed(int index) {
    setState(() {
      _selectedIndex = index;
      switch(_selectedIndex)  {
        case 0:
          textToDisplay = '$_selectedIndex : Home';
          break;
        case 1:
          textToDisplay = '1 : Reports';
          break;
        case 2:
          textToDisplay = '2 : Calendar';
          break;
        case 3:
          textToDisplay = '3 : Settings';
          break;
        default:
          textToDisplay = '0 : Home';
          break;
      }
    });
  }
}
