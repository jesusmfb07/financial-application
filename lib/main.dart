import 'package:exercises_flutter2/shared/ui/navigation_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat/infrastructure/adapters/contact_adapter.dart';
import 'chat/ui/pages/expense_manager_page.dart';
import 'finances/myFinances/infrastructure/adapters/income_adapter.dart';
import 'finances/myFinances/ui/myFinancesPages/my_finance_page.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider(create: (_) => ContactAdapter()),
        Provider(create: (_) => FinanceEntrySQLiteAdapter()), // Agregar el proveedor FinanceEntryAdapter
      ],
      child: MaterialApp(
        title: 'Gestor de Gastos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/', // Agregamos la ruta inicial
        routes: {
          '/': (context) => ExpenseManagerPage(), // Ruta inicial (ExpenseManagerPage)
            '/my-finances': (context) => MyFinancesPage(), // Ruta para la página MyFinancesPage
        },
      ),
    );
  }
}




