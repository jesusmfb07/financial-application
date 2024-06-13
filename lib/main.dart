
import 'package:flutter/material.dart';
import 'chat/ui/pages/expense_manager_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Gastos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseManagerPage(),
    );
  }
}