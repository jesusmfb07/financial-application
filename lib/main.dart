import 'package:exercises_flutter2/settings/infrastructure/backup_manager.dart';
import 'package:exercises_flutter2/shared/ui/navigation_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'finances/infrastructure/adapters/egress_adapter.dart';
import 'finances/infrastructure/adapters/income_adapter.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final incomeAdapter = IncomeEntrySQLiteAdapter();
  final egressAdapter = EgressEntrySQLiteAdapter();

  await incomeAdapter.database;
  await egressAdapter.database;

  final backupManager = BackupManager(
    incomeAdapter: incomeAdapter,
    egressAdapter: egressAdapter,
  );

  runApp(MyApp(
    incomeAdapter: incomeAdapter,
    egressAdapter: egressAdapter,
    backupManager: backupManager,
  ));
}

class MyApp extends StatelessWidget {
  final IncomeEntrySQLiteAdapter incomeAdapter;
  final EgressEntrySQLiteAdapter egressAdapter;
  final BackupManager backupManager;

  MyApp({required this.incomeAdapter, required this.egressAdapter, required this.backupManager});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => egressAdapter),
        Provider(create: (_) => incomeAdapter),
        Provider(create: (_) => backupManager),
      ],
      child: MaterialApp(
        title: 'Gestor de Gastos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(), // Aquí se usa HomePage como la página principal
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

