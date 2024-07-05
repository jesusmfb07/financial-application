import 'package:exercises_flutter2/shared/ui/navigation_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'finances/infrastructure/adapters/egress_adapter.dart';
import 'finances/infrastructure/adapters/income_adapter.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the database adapters
  final incomeAdapter = IncomeEntrySQLiteAdapter();
  final egressAdapter = EgressEntrySQLiteAdapter();

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
        home: HomePage(),
      ),
    );
  }
}