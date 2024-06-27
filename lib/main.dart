import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat/ui/pages/expense_manager_page.dart';
import 'finances/infrastructure/adapters/egress_adapter.dart';
import 'finances/infrastructure/adapters/income_adapter.dart';
import 'finances/ui/myFinancesPages/my_finance_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await EgressEntrySQLiteAdapter().deleteDatabase(); // Eliminar la base de datos para pruebas
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider(create: (_) => ContactAdapter()), // Comentar o descomentar según necesidad
        Provider(create: (_) => EgressEntrySQLiteAdapter()),
        Provider(create: (_) => IncomeEntrySQLiteAdapter()),
      ],
      child: MaterialApp(
        title: 'Gestor de Gastos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/', // Ruta inicial
        routes: {
          '/': (context) => ExpenseManagerPage(), // Ruta inicial (ExpenseManagerPage)
          '/my-finances': (context) => MyFinancesPage(), // Ruta para la página MyFinancesPage
        },
      ),
    );
  }
}
