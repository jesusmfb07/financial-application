// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:exercises_flutter2/main.dart';
// import 'package:exercises_flutter2/finances/infrastructure/adapters/egress_adapter.dart';
// import 'package:exercises_flutter2/finances/infrastructure/adapters/income_adapter.dart';
//
// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Initialize the database adapters
//     final incomeAdapter = IncomeEntrySQLiteAdapter();
//     final egressAdapter = EgressEntrySQLiteAdapter();
//
//     // Ensure the database is initialized
//     await incomeAdapter.database;
//     await egressAdapter.database;
//
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(MyApp(
//       incomeAdapter: incomeAdapter,
//       egressAdapter: egressAdapter,
//     ));
//
//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);
//
//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//
//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }


import 'package:exercises_flutter2/settings/ui/mySettings/backup_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:exercises_flutter2/main.dart';
import 'package:exercises_flutter2/finances/infrastructure/adapters/egress_adapter.dart';
import 'package:exercises_flutter2/finances/infrastructure/adapters/income_adapter.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Initialize the database adapters
    final incomeAdapter = IncomeEntrySQLiteAdapter();
    final egressAdapter = EgressEntrySQLiteAdapter();

    // Ensure the database is initialized
    await incomeAdapter.database;
    await egressAdapter.database;

    // Initialize BackupManager
    final backupManager = BackupManager(
      incomeAdapter: incomeAdapter,
      egressAdapter: egressAdapter,
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider(create: (_) => incomeAdapter),
          Provider(create: (_) => egressAdapter),
          Provider(create: (_) => backupManager),
        ],
        child: MyApp(
          incomeAdapter: incomeAdapter,
          egressAdapter: egressAdapter,
          backupManager: backupManager,
        ),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
