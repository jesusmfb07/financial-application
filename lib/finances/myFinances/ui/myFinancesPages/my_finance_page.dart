import 'package:flutter/material.dart';
import '../../../../category/application/use_cases/category_use_case.dart';
import '../../../../category/application/use_cases/handler/queries/get_categories_command.dart';
import '../../../../category/domain/aggregates/category_aggregate.dart';
import '../../../../category/infrastructure/adapters/categorySQLiteAdapter.dart';
import '../../../../category/ui/myCategory/category_page.dart';
import '../../../../shared/ui/navigation_bar_page.dart';
import '../../application/ports/egress_port.dart';
import '../../application/ports/income_port.dart';
import '../../application/use_cases/egress_use_case.dart';
import '../../application/use_cases/handler/command/create_egress_command.dart';
import '../../application/use_cases/handler/command/create_income_command.dart';
import '../../application/use_cases/handler/command/update_egress_command.dart';
import '../../application/use_cases/handler/command/update_income_command.dart';
import '../../application/use_cases/handler/queries/get_egress_query.dart';
import '../../application/use_cases/handler/queries/get_income_query.dart';
import '../../application/use_cases/income_use_case.dart';
import '../../domain/aggregates/egress_aggregate.dart';
import '../../domain/aggregates/income_aggregate.dart';
import '../../infrastructure/adapters/egress_adapter.dart';
import '../../infrastructure/adapters/income_adapter.dart';
import 'egress_page.dart';
import 'income_page.dart';

class MyFinancesPage extends StatefulWidget {
  @override
  _MyFinancesPageState createState() => _MyFinancesPageState();
}

class _MyFinancesPageState extends State<MyFinancesPage> {
  int _selectedIndex = 0;

  late IncomeEntryAggregate incomeAggregate;
  late EgressEntryAggregate egressAggregate;
  late CategoryAggregate categoryAggregate;
  late IncomeEntryPort incomeEntryPort;
  late EgressEntryPort egressEntryPort;
  late CreateIncomeEntryUseCase createIncomeEntryUseCase;
  late UpdateIncomeEntryUseCase updateIncomeEntryUseCase;
  late GetIncomeEntriesUseCase getIncomeEntriesUseCase;
  late CreateEgressEntryUseCase createEgressEntryUseCase;
  late UpdateEgressEntryUseCase updateEgressEntryUseCase;
  late GetEgressEntriesUseCase getEgressEntriesUseCase;
  late GetCategoriesUseCase getCategoriesUseCase;

  @override
  void initState() {
    super.initState();
    _initializeDependencies();
  }

  void _initializeDependencies() {
    incomeEntryPort = IncomeEntrySQLiteAdapter();
    egressEntryPort = EgressEntrySQLiteAdapter();
    categoryAggregate = CategoryAggregate(categories: []);
    incomeAggregate = IncomeEntryAggregate(entries: []);
    egressAggregate = EgressEntryAggregate(entries: []);
    createIncomeEntryUseCase = CreateIncomeEntryCommand(incomeEntryPort);
    updateIncomeEntryUseCase = UpdateIncomeEntryCommand(incomeEntryPort);
    getIncomeEntriesUseCase = GetIncomeEntriesQuery(incomeEntryPort);
    createEgressEntryUseCase = CreateEgressEntryCommand(egressEntryPort);
    updateEgressEntryUseCase = UpdateEgressEntryCommand(egressEntryPort);
    getEgressEntriesUseCase = GetEgressEntriesQuery(egressEntryPort);
    getCategoriesUseCase = GetCategoriesQuery(CategorySQLiteAdapter());

    _loadInitialData();
  }

  void _loadInitialData() async {
    final incomeEntries = await getIncomeEntriesUseCase.execute(incomeAggregate);
    final egressEntries = await getEgressEntriesUseCase.execute(egressAggregate);
    final categories = await getCategoriesUseCase.execute(categoryAggregate);

    setState(() {
      incomeAggregate = IncomeEntryAggregate(entries: incomeEntries);
      egressAggregate = EgressEntryAggregate(entries: egressEntries);
      categoryAggregate = CategoryAggregate(categories: categories);
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
        getCategoriesUseCase: getCategoriesUseCase,
        aggregate: incomeAggregate,
        categoryAggregate: categoryAggregate,
      )
          : EgressPage(
        createEntryUseCase: createEgressEntryUseCase,
        updateEntryUseCase: updateEgressEntryUseCase,
        getEntriesUseCase: getEgressEntriesUseCase,
        aggregate: egressAggregate,
        categories: categoryAggregate.categories.map((e) => e.name).toList(),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
