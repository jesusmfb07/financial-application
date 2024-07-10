import 'package:flutter/material.dart';
import '../../../../shared/categories/application/use_cases/get_category_use_case.dart';
import '../../../../shared/categories/application/use_cases/handler/queries/get_categories_command.dart';
import '../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../../shared/categories/infrastructure/adapters/category_sqlite_adapter.dart';
import '../../../../shared/providers/application/use_cases/handler/queries/get_provider_query.dart';
import '../../../../shared/providers/domain/aggregates/provider_aggregate.dart';
import '../../../../shared/providers/infrastructure/adapters/provider_database_adapter.dart';
import '../../../shared/categories/application/use_cases/create_category_use_case.dart';
import '../../../shared/categories/application/use_cases/handler/command/create_category_command.dart';
import '../../../shared/providers/application/use_cases/create_provider_use_case.dart';
import '../../../shared/providers/application/use_cases/get_providers_use_case.dart';
import '../../../shared/providers/application/use_cases/handler/command/create_provider_command.dart';
import '../../application/ports/egress_port.dart';
import '../../application/ports/income_port.dart';
import '../../application/use_cases/create_egress_use_case.dart';
import '../../application/use_cases/create_income_use_case.dart';
import '../../application/use_cases/egress_use_case.dart';
import '../../application/use_cases/get_egress_use_case.dart';
import '../../application/use_cases/get_income_use_case.dart';
import '../../application/use_cases/handler/command/create_egress_command.dart';
import '../../application/use_cases/handler/command/create_income_command.dart';
import '../../application/use_cases/handler/command/update_egress_command.dart';
import '../../application/use_cases/handler/command/update_income_command.dart';
import '../../application/use_cases/handler/queries/get_egress_query.dart';
import '../../application/use_cases/handler/queries/get_income_query.dart';
import '../../application/use_cases/update_egress_use_case.dart';
import '../../application/use_cases/update_income_use_case.dart';
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
  int _selectedFinanceTabIndex = 0; // For Income (0) and Egress (1)

  late List<EgressEntryAggregate> egressAggregates;
  late List<CategoryAggregate> categoryAggregates;
  late List<ProviderAggregate> providerAggregates;
  late List<IncomeEntryAggregate>incomeAggregates;
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
    categoryAggregates = [];
    providerAggregates = [];
    incomeAggregates = [];
    egressAggregates = [];
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
    final incomeEntries = await getIncomeEntriesUseCase.execute();
    final egressEntries = await getEgressEntriesUseCase.execute();
    final categories = await getCategoriesUseCase.execute();
    final providers = await getProvidersUseCase.execute();

    setState(() {
      incomeAggregates = incomeEntries;
      egressAggregates = egressEntries;
      categoryAggregates = categories;
      providerAggregates = providers;
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
              selectedBorderColor: Colors.teal, // Borde del botón seleccionado en teal
              selectedColor: Colors.white, // Texto del botón seleccionado en blanco
              fillColor: Colors.teal, // Fondo del botón seleccionado en teal
              color: Colors.black,
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
        categoryAggregates: categoryAggregates,
      )
          : EgressPage(
        createEntryUseCase: createEgressEntryUseCase,
        updateEntryUseCase: updateEgressEntryUseCase,
        getEntriesUseCase: getEgressEntriesUseCase,
        getCategoriesUseCase: getCategoriesUseCase,
        getProvidersUseCase: getProvidersUseCase,
        createCategoryUseCase: createCategoryUseCase,
        createProviderUseCase: createProviderUseCase,
        categoryAggregates: categoryAggregates,
        providerAggregates: providerAggregates,
      ),
    );
  }
}
