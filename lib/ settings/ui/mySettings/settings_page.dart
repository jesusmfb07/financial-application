// ui/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../category/application/use_cases/handler/command/create_category_command.dart';
import '../../../category/application/use_cases/handler/command/delete_category_command.dart';
import '../../../category/application/use_cases/handler/command/update_category_command.dart';
import '../../../category/application/use_cases/handler/queries/get_categories_command.dart';
import '../../../category/domain/aggregates/category_aggregate.dart';
import '../../../category/infrastructure/adapters/categorySQLiteAdapter.dart';
import '../../../category/ui/myCategory/category_page.dart';
import '../../../chat/ui/pages/expense_manager_page.dart';
import '../../application/ports/settings_port.dart';
import '../../application/use_cases/handler/command/Currency_command.dart';
import '../../application/use_cases/handler/command/Providers_command.dart';
import '../../application/use_cases/handler/command/categories_command.dart';
import '../../application/use_cases/handler/command/reminders_command.dart';
import '../../infrastructure/adapters/settings_adapter.dart';
import '../../../shared/ui/navigation_bar_page.dart';


class SettingsPage extends StatelessWidget {
  final SettingsPort settingsPort = SettingsAdapter();
  int _selectedIndex = 3; // Ajustes es el cuarto elemento

  @override
  Widget build(BuildContext context) {
    final navigateToRemindersCommand = NavigateToRemindersCommand(settingsPort);
    final navigateToCategoriesCommand = NavigateToCategoriesCommand(settingsPort);
    final navigateToProvidersCommand = NavigateToProvidersCommand(settingsPort);
    final navigateToCurrencyCommand = NavigateToCurrencyCommand(settingsPort);

    void _onItemTapped(int index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExpenseManagerPage()),
        );
      } else if (index != _selectedIndex) {
        _selectedIndex = index;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
      }
    }

    String formattedDate = DateFormat('dd/MM/yy').format(DateTime.now());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.teal,
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      'JM',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jesus Mendoza',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.folder),
                    title: Text('Recordatorios'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () async {
                      await navigateToRemindersCommand.execute();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.category),
                    title: Text('Categorías'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                            createCategoryUseCase: CreateCategoryCommand(CategorySQLiteAdapter()),
                            updateCategoryUseCase: UpdateCategoryCommand(CategorySQLiteAdapter()),
                            deleteCategoryUseCase: DeleteCategoryCommand(CategorySQLiteAdapter()),
                            getCategoriesUseCase: GetCategoriesQuery(CategorySQLiteAdapter()),
                            aggregate: CategoryAggregate(categories: []),
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.business),
                    title: Text('Proveedores'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () async {
                      await navigateToProvidersCommand.execute();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.attach_money),
                    title: Text('Moneda por defecto'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () async {
                      await navigateToCurrencyCommand.execute();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
