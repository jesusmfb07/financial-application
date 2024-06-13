
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat/infrastructure/adapters/chat_adapter.dart';
import 'chat/ui/pages/expense_manager_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ChatAdapter()),
      ],
      child: MaterialApp(
        title: 'Gestor de Gastos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ExpenseManagerPage(),
      ),
    );
  }
}