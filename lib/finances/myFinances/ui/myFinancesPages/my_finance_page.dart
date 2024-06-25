// import 'package:flutter/material.dart';
// import '../../../../Provider/domain/entities/provider_entity.dart';
// import '../../../../category/domain/entities/category_entity.dart';
// import '../../../../shared/ui/navigation_bar_page.dart';
// import '../../../egressEntry/application/ports/egress_entry_port.dart';
// import '../../../egressEntry/application/use_cases/egress_entry_use_case.dart';
// import '../../../egressEntry/application/use_cases/handler/command/create_egress_entry_command.dart';
// import '../../../egressEntry/application/use_cases/handler/command/delete_egress_entry_command.dart';
// import '../../../egressEntry/application/use_cases/handler/command/update_egress_entry_command.dart';
// import '../../../egressEntry/application/use_cases/handler/queries/get_egress_entry_query.dart';
// import '../../../egressEntry/domain/aggregates/egress_entry_aggregate.dart';
// import '../../../egressEntry/infrastructure/adapters/egress_entry_adapter.dart';
// import '../../../egressEntry/ui/egress/egress.dart';
// import '../../../incomeEntry/application/ports/income_entry_port.dart';
// import '../../../incomeEntry/application/use_cases/handler/command/create_income_entry_command.dart';
// import '../../../incomeEntry/application/use_cases/handler/command/delete_income_entry_command.dart';
// import '../../../incomeEntry/application/use_cases/handler/command/update_income_entry_command.dart';
// import '../../../incomeEntry/application/use_cases/handler/queries/get_income_entry_query.dart';
// import '../../../incomeEntry/application/use_cases/income_entry_use_case.dart';
// import '../../../incomeEntry/domain/aggregates/income_entry_aggregate.dart';
// import '../../../incomeEntry/infrastructure/adapters/income_entry_adapter.dart';
// import '../../../incomeEntry/ui/income/income.dart';
//
// class MyFinancesPage extends StatefulWidget {
//   @override
//   _MyFinancesPageState createState() => _MyFinancesPageState();
// }
//
// class _MyFinancesPageState extends State<MyFinancesPage> {
//   int _selectedIndex = 0;
//
//   late IncomeEntryPort incomeEntryPort;
//   late CreateIncomeEntryUseCase createIncomeEntryUseCase;
//   late UpdateIncomeEntryUseCase updateIncomeEntryUseCase;
//   late DeleteIncomeEntryUseCase deleteIncomeEntryUseCase;
//   late GetIncomeEntriesUseCase getIncomeEntriesUseCase;
//   late IncomeEntryAggregate incomeEntryAggregate;
//   late List<Category> incomeCategories;
//
//   late EgressEntryPort egressEntryPort;
//   late CreateEgressEntryUseCase createEgressEntryUseCase;
//   late UpdateEgressEntryUseCase updateEgressEntryUseCase;
//   late DeleteEgressEntryUseCase deleteEgressEntryUseCase;
//   late GetEgressEntriesUseCase getEgressEntriesUseCase;
//   late EgressEntryAggregate egressEntryAggregate;
//   late List<Category> egressCategories;
//   late List<Provider> egressProviders;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Inicialización de casos de uso y adaptadores para ingresos
//     incomeEntryPort = IncomeEntrySQLiteAdapter();
//     createIncomeEntryUseCase = CreateIncomeEntryCommand(incomeEntryPort);
//     updateIncomeEntryUseCase = UpdateIncomeEntryCommand(incomeEntryPort);
//     deleteIncomeEntryUseCase = DeleteIncomeEntryCommand(incomeEntryPort);
//     getIncomeEntriesUseCase = GetIncomeEntriesQuery(incomeEntryPort);
//     incomeEntryAggregate = IncomeEntryAggregate(entries: []);
//     incomeCategories = <Category>[]; // Asegúrate de llenar esto con tus categorías de ingresos
//
//     // Inicialización de casos de uso y adaptadores para egresos
//     egressEntryPort = EgressEntrySQLiteAdapter();
//     createEgressEntryUseCase = CreateEgressEntryCommand(egressEntryPort);
//     updateEgressEntryUseCase = UpdateEgressEntryCommand(egressEntryPort);
//     deleteEgressEntryUseCase = DeleteEgressEntryCommand(egressEntryPort);
//     getEgressEntriesUseCase = GetEgressEntriesQuery(egressEntryPort);
//     egressEntryAggregate = EgressEntryAggregate(entries: []);
//     egressCategories = <Category>[];
//     egressProviders = <Provider>[];
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mis Finanzas'),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(48.0),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: ToggleButtons(
//               borderRadius: BorderRadius.circular(8.0),
//               selectedBorderColor: Theme.of(context).colorScheme.primary,
//               selectedColor: Colors.white,
//               fillColor: Theme.of(context).colorScheme.primary,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 50.0),
//                   child: Text('Ingreso'),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 50.0),
//                   child: Text('Egreso'),
//                 ),
//               ],
//               isSelected: [
//                 _selectedIndex == 0,
//                 _selectedIndex == 1,
//               ],
//               onPressed: (index) {
//                 _onItemTapped(index);
//               },
//             ),
//           ),
//         ),
//       ),
//       body: _selectedIndex == 0
//           ? IncomePage(
//         createEntryUseCase: createIncomeEntryUseCase,
//         updateEntryUseCase: updateIncomeEntryUseCase,
//         deleteEntryUseCase: deleteIncomeEntryUseCase,
//         getEntriesUseCase: getIncomeEntriesUseCase,
//         aggregate: incomeEntryAggregate,
//         categories: incomeCategories,
//       )
//           : EgressPage(
//         createEntryUseCase: createEgressEntryUseCase,
//         updateEntryUseCase: updateEgressEntryUseCase,
//         deleteEntryUseCase: deleteEgressEntryUseCase,
//         getEntriesUseCase: getEgressEntriesUseCase,
//         aggregate: egressEntryAggregate,
//         categories: egressCategories,
//         providers: egressProviders,
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import '../../../../shared/ui/navigation_bar_page.dart';
// import 'egress_page.dart';
// import 'income_page.dart';
//
// class MyFinancesPage extends StatefulWidget {
//   @override
//   _MyFinancesPageState createState() => _MyFinancesPageState();
// }
//
// class _MyFinancesPageState extends State<MyFinancesPage> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mis Finanzas'),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(48.0),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: ToggleButtons(
//               borderRadius: BorderRadius.circular(8.0),
//               selectedBorderColor: Theme.of(context).colorScheme.primary,
//               selectedColor: Colors.white,
//               fillColor: Theme.of(context).colorScheme.primary,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 50.0),
//                   child: Text('Ingreso'),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 50.0),
//                   child: Text('Egreso'),
//                 ),
//               ],
//               isSelected: [
//                 _selectedIndex == 0,
//                 _selectedIndex == 1,
//               ],
//               onPressed: (index) {
//                 _onItemTapped(index);
//               },
//             ),
//           ),
//         ),
//       ),
//       body: _selectedIndex == 0
//           ? IncomePage()
//           : EgressPage(),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../../../shared/ui/navigation_bar_page.dart';
import '../../application/ports/egress_port.dart';
import '../../application/ports/income_port.dart';
import '../../application/use_cases/handler/command/create_egress_command.dart';
import '../../application/use_cases/handler/command/create_income_command.dart';
import '../../application/use_cases/handler/command/update_egress_command.dart';
import '../../application/use_cases/handler/command/update_income_command.dart';
import '../../application/use_cases/handler/queries/get_egress_query.dart';
import '../../application/use_cases/handler/queries/get_income_query.dart';
import '../../domain/aggregates/egress_aggregate.dart';
import '../../domain/aggregates/income_aggregate.dart';
import '../../infrastructure/adapters/egress_adapter.dart';
import '../../infrastructure/adapters/income_adapter.dart';
import 'income_page.dart';
import 'egress_page.dart';
import '../../application/use_cases/income_use_case.dart';
import '../../application/use_cases/egress_use_case.dart';


class MyFinancesPage extends StatefulWidget {
  @override
  _MyFinancesPageState createState() => _MyFinancesPageState();
}

class _MyFinancesPageState extends State<MyFinancesPage> {
  int _selectedIndex = 0;

  // Agregados
  late IncomeEntryAggregate incomeAggregate;
  late EgressEntryAggregate egressAggregate;

  // Puertos (interfaces)
  late IncomeEntryPort incomeEntryPort;
  late EgressEntryPort egressEntryPort;

  // Casos de uso
  late CreateIncomeEntryUseCase createIncomeEntryUseCase;
  late UpdateIncomeEntryUseCase updateIncomeEntryUseCase;
  late GetIncomeEntriesUseCase getIncomeEntriesUseCase;
  late CreateEgressEntryUseCase createEgressEntryUseCase;
  late UpdateEgressEntryUseCase updateEgressEntryUseCase;
  late GetEgressEntriesUseCase getEgressEntriesUseCase;

  // Lista de categorías
  final List<String> categories = ["Food", "Transport", "Entertainment", "Bills"];

  @override
  void initState() {
    super.initState();
    _initializeDependencies();
  }

  void _initializeDependencies() {
    // Inicializar puertos (adapters)
    incomeEntryPort = IncomeEntrySQLiteAdapter();
    egressEntryPort = EgressEntrySQLiteAdapter();

    // Inicializar agregados
    incomeAggregate = IncomeEntryAggregate(entries: []);
    egressAggregate = EgressEntryAggregate(entries: []);

    // Inicializar casos de uso
    createIncomeEntryUseCase = CreateIncomeEntryCommand(incomeEntryPort);
    updateIncomeEntryUseCase = UpdateIncomeEntryCommand(incomeEntryPort);
    getIncomeEntriesUseCase = GetIncomeEntriesQuery(incomeEntryPort);
    createEgressEntryUseCase = CreateEgressEntryCommand(egressEntryPort);
    updateEgressEntryUseCase = UpdateEgressEntryCommand(egressEntryPort);
    getEgressEntriesUseCase = GetEgressEntriesQuery(egressEntryPort);

    _loadInitialData();
  }

  void _loadInitialData() async {
    final incomeEntries = await getIncomeEntriesUseCase.execute(incomeAggregate);
    final egressEntries = await getEgressEntriesUseCase.execute(egressAggregate);

    setState(() {
      incomeAggregate = IncomeEntryAggregate(entries: incomeEntries);
      egressAggregate = EgressEntryAggregate(entries: egressEntries);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Finanzas'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(8.0),
              selectedBorderColor: Theme.of(context).colorScheme.primary,
              selectedColor: Colors.white,
              fillColor: Theme.of(context).colorScheme.primary,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text('Ingreso'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text('Egreso'),
                ),
              ],
              isSelected: [
                _selectedIndex == 0,
                _selectedIndex == 1,
              ],
              onPressed: (index) {
                _onItemTapped(index);
              },
            ),
          ),
        ),
      ),
      body: _selectedIndex == 0
          ? IncomePage(
        createEntryUseCase: createIncomeEntryUseCase,
        updateEntryUseCase: updateIncomeEntryUseCase,
        getEntriesUseCase: getIncomeEntriesUseCase,
        aggregate: incomeAggregate,
        categories: categories,
      )
          : EgressPage(
        createEntryUseCase: createEgressEntryUseCase,
        updateEntryUseCase: updateEgressEntryUseCase,
        getEntriesUseCase: getEgressEntriesUseCase,
        aggregate: egressAggregate,
        categories: categories,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

