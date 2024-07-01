import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat/ui/pages/expense_manager_page.dart';
import 'finances/infrastructure/adapters/egress_adapter.dart';
import 'finances/infrastructure/adapters/income_adapter.dart';
import 'finances/ui/myFinancesPages/my_finance_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the database adapters
  final incomeAdapter = IncomeEntrySQLiteAdapter();
  final egressAdapter = EgressEntrySQLiteAdapter();

  // Optionally delete the database for testing purposes
  await incomeAdapter.deleteDatabase();

  // Ensure the database is initialized
  await incomeAdapter.database;
  await egressAdapter.database;

  runApp(MyApp(
    incomeAdapter: incomeAdapter,
    egressAdapter: egressAdapter,
  ));
}

class MyApp extends StatelessWidget {
  final IncomeEntrySQLiteAdapter incomeAdapter;
  final EgressEntrySQLiteAdapter egressAdapter;

  MyApp({required this.incomeAdapter, required this.egressAdapter});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => egressAdapter),
        Provider(create: (_) => incomeAdapter),
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
