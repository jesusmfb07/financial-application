import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graficos'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(icon: Icon(Icons.calendar_today), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Text('No registers found.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the add button
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
