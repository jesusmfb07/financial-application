import 'package:flutter/material.dart';
import 'chat/ui/pages/chat_page.dart';
import 'chat/infrastructure/adapters/chat_adapter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Gastos',
      debugShowCheckedModeBanner: false,
      home: ChatPage(adapter: ChatAdapter()),
    );
  }
}