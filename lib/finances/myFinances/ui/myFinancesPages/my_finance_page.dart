import 'package:exercises_flutter2/finances/egressEntry/application/use_cases/handler/queries/get_egress_entry_query.dart';
import 'package:flutter/material.dart';
import '../../../../Provider/domain/entities/provider_entity.dart';
import '../../../../category/domain/entities/category_entity.dart';
import '../../../../shared/ui/navigation_bar_page.dart';
import '../../../egressEntry/application/ports/egress_entry_port.dart';
import '../../../egressEntry/application/use_cases/handler/command/create_egress_entry_command.dart';
import '../../../egressEntry/application/use_cases/handler/command/delete_egress_entry_command.dart';
import '../../../egressEntry/application/use_cases/handler/command/update_egress_entry_command.dart';
import '../../../egressEntry/domain/aggregates/egress_entry_aggregate.dart';
import '../../../egressEntry/ui/egress/egress.dart';
import '../../../incomeEntry/application/ports/income_entry_port.dart';
import '../../../incomeEntry/application/use_cases/handler/command/create_income_entry_command.dart';
import '../../../incomeEntry/application/use_cases/handler/command/delete_income_entry_command.dart';
import '../../../incomeEntry/application/use_cases/handler/command/update_income_entry_command.dart';
import '../../../incomeEntry/application/use_cases/handler/queries/get_income_entry_query.dart';
import '../../../incomeEntry/domain/aggregates/income_entry_aggregate.dart';
import '../../../incomeEntry/infrastructure/adapters/income_entry_adapter.dart';
import '../../../incomeEntry/ui/income/income.dart';


class MyFinancesPage extends StatefulWidget {
  @override
  _MyFinancesPageState createState() => _MyFinancesPageState();
}

class _MyFinancesPageState extends State<MyFinancesPage> {
  int _selectedIndex = 0;

  // Instancias necesarias para IncomePage
  final incomeEntryPort = IncomeEntrySQLiteAdapter();
  final createIncomeEntryUseCase = CreateIncomeEntryCommand(IncomeEntryPort as IncomeEntryPort);
  final updateIncomeEntryUseCase = UpdateIncomeEntryCommand(IncomeEntryPort as IncomeEntryPort);
  final deleteIncomeEntryUseCase = DeleteIncomeEntryCommand(IncomeEntryPort as IncomeEntryPort);
  final getIncomeEntriesUseCase = GetIncomeEntriesQuery(IncomeEntryPort as IncomeEntryPort);
  final incomeEntryAggregate = IncomeEntryAggregate(entries: []);
  final incomeCategories = <Category>[]; // Llena esto con tu lista de categorías

  // Instancias necesarias para EgressPage
  final createEgressEntryUseCase = CreateEgressEntryCommand(EgressEntryPort as EgressEntryPort);
  final updateEgressEntryUseCase = UpdateEgressEntryCommand(EgressEntryPort as EgressEntryPort);
  final deleteEgressEntryUseCase = DeleteEgressEntryCommand(EgressEntryPort as EgressEntryPort);
  final getEgressEntriesUseCase = GetEgressEntriesQuery(EgressEntryPort as EgressEntryPort);
  final egressEntryAggregate = EgressEntryAggregate(entries: []);
  final egressCategories = <Category>[]; // Llena esto con tu lista de categorías
  final egressProviders = <Provider>[]; // Llena esto con tu lista de proveedores

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
        deleteEntryUseCase: deleteIncomeEntryUseCase,
        getEntriesUseCase: getIncomeEntriesUseCase,
        aggregate: incomeEntryAggregate,
        categories: incomeCategories,
      )
          : EgressPage(
        createEntryUseCase: createEgressEntryUseCase,
        updateEntryUseCase: updateEgressEntryUseCase,
        deleteEntryUseCase: deleteEgressEntryUseCase,
        getEntriesUseCase: getEgressEntriesUseCase,
        aggregate: egressEntryAggregate,
        categories: egressCategories,
        providers: egressProviders,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
