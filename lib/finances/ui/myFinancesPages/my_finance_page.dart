import 'package:flutter/material.dart';
import '../../../../shared/categories/application/use_cases/category_use_case.dart';
import '../../../../shared/categories/application/use_cases/handler/queries/get_categories_command.dart';
import '../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../../shared/categories/infrastructure/adapters/category_sqlite_adapter.dart';
import '../../../../shared/providers/application/use_cases/handler/queries/get_provider_query.dart';
import '../../../../shared/providers/application/use_cases/provider_use_case.dart';
import '../../../../shared/providers/domain/aggregates/provider_aggregate.dart';
import '../../../../shared/providers/infrastructure/adapters/provider_database_adapter.dart';
import '../../../../shared/ui/navigation_bar_page.dart';
import '../../../shared/categories/application/use_cases/handler/command/create_category_command.dart';
import '../../../shared/providers/application/use_cases/handler/command/create_provider_command.dart';
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
import 'egress/egress_page.dart';
import 'income/income_page.dart';

class MyFinancesPage extends StatefulWidget {
  @override
  _MyFinancesPageState createState() => _MyFinancesPageState();
}

class _MyFinancesPageState extends State<MyFinancesPage> {
  int _selectedIndex = 0;
  int _selectedFinanceTabIndex = 0; // For Income (0) and Egress (1)

  late IncomeEntryAggregate incomeAggregate;
  late EgressEntryAggregate egressAggregate;
  late CategoryAggregate categoryAggregate;
  late ProviderAggregate providerAggregate;
  late IncomeEntryPort incomeEntryPort;
  late EgressEntryPort egressEntryPort;
  late CreateIncomeEntryUseCase createIncomeEntryUseCase;
  late UpdateIncomeEntryUseCase updateIncomeEntryUseCase;
  late GetIncomeEntriesUseCase getIncomeEntriesUseCase;
  late CreateEgressEntryUseCase createEgressEntryUseCase;
  late UpdateEgressEntryUseCase updateEgressEntryUseCase;
  late GetEgressEntriesUseCase getEgressEntriesUseCase;
  late GetCategoriesUseCase getCategoriesUseCase;
  late GetProvidersUseCase getProvidersUseCase;
  late CreateCategoryUseCase createCategoryUseCase; // Añadir esto
  late CreateProviderUseCase createProviderUseCase;

  @override
  void initState() {
    super.initState();
    _initializeDependencies();
  }

  void _initializeDependencies() {
    incomeEntryPort = IncomeEntrySQLiteAdapter();
    egressEntryPort = EgressEntrySQLiteAdapter();
    categoryAggregate = CategoryAggregate(categories: []);
    providerAggregate = ProviderAggregate(providers: []);
    incomeAggregate = IncomeEntryAggregate(entries: []);
    egressAggregate = EgressEntryAggregate(entries: []);
    createIncomeEntryUseCase = CreateIncomeEntryCommand(incomeEntryPort);
    updateIncomeEntryUseCase = UpdateIncomeEntryCommand(incomeEntryPort);
    getIncomeEntriesUseCase = GetIncomeEntriesQuery(incomeEntryPort);
    createEgressEntryUseCase = CreateEgressEntryCommand(egressEntryPort);
    updateEgressEntryUseCase = UpdateEgressEntryCommand(egressEntryPort);
    getEgressEntriesUseCase = GetEgressEntriesQuery(egressEntryPort);
    getCategoriesUseCase = GetCategoriesQuery(CategorySQLiteAdapter());
    getProvidersUseCase = GetProvidersQuery(ProviderSQLiteAdapter());
    createCategoryUseCase = CreateCategoryCommand(CategorySQLiteAdapter()); // Inicializar esto
    createProviderUseCase = CreateProviderCommand(ProviderSQLiteAdapter()); // Inicializar esto

    _loadInitialData();
  }

  void _loadInitialData() async {
    final incomeEntries = await getIncomeEntriesUseCase.execute(incomeAggregate);
    final egressEntries = await getEgressEntriesUseCase.execute(egressAggregate);
    final categories = await getCategoriesUseCase.execute(categoryAggregate);
    final providers = await getProvidersUseCase.execute(providerAggregate);

    setState(() {
      incomeAggregate = IncomeEntryAggregate(entries: incomeEntries);
      egressAggregate = EgressEntryAggregate(entries: egressEntries);
      categoryAggregate = CategoryAggregate(categories: categories);
      providerAggregate = ProviderAggregate(providers: providers);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFinanceTabTapped(int index) {
    setState(() {
      _selectedFinanceTabIndex = index;
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
                _selectedFinanceTabIndex == 0,
                _selectedFinanceTabIndex == 1,
              ],
              onPressed: (index) {
                _onFinanceTabTapped(index);
              },
            ),
          ),
        ),
      ),
      body: _selectedFinanceTabIndex == 0
          ? IncomePage(
        createEntryUseCase: createIncomeEntryUseCase,
        updateEntryUseCase: updateIncomeEntryUseCase,
        getEntriesUseCase: getIncomeEntriesUseCase,
        getCategoriesUseCase: getCategoriesUseCase,
        createCategoryUseCase: createCategoryUseCase, // Pasar esto
        aggregate: incomeAggregate,
        categoryAggregate: categoryAggregate,
      )
          : EgressPage(
        createEntryUseCase: createEgressEntryUseCase,
        updateEntryUseCase: updateEgressEntryUseCase,
        getEntriesUseCase: getEgressEntriesUseCase,
        getCategoriesUseCase: getCategoriesUseCase,
        getProvidersUseCase: getProvidersUseCase,
        createCategoryUseCase: createCategoryUseCase,
        createProviderUseCase: createProviderUseCase,
        aggregate: egressAggregate,
        categoryAggregate: categoryAggregate,
        providerAggregate: providerAggregate,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
