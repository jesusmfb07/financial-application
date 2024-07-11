import 'package:flutter/material.dart';
import '../../../shared/categories/application/use_cases/handler/command/create_category_command.dart';
import '../../../shared/categories/application/use_cases/handler/command/delete_category_command.dart';
import '../../../shared/categories/application/use_cases/handler/command/update_category_command.dart';
import '../../../shared/categories/application/use_cases/handler/queries/get_categories_command.dart';
import '../../../shared/categories/infrastructure/adapters/category_sqlite_adapter.dart';
import '../../../shared/categories/ui/myCategory/category_page.dart';
import '../../../shared/currencies/application/use_cases/handler/command/set_currency_command.dart';
import '../../../shared/currencies/application/use_cases/handler/queries/get_currency_query.dart';
import '../../../shared/currencies/application/use_cases/handler/queries/get_default_currency_query.dart';
import '../../../shared/currencies/infrastructure/adapters/currency_adapter.dart';
import '../../../shared/currencies/ui/currency_page.dart';
import '../../../shared/providers/application/use_cases/handler/command/create_provider_command.dart';
import '../../../shared/providers/application/use_cases/handler/command/delete_provider_command.dart';
import '../../../shared/providers/application/use_cases/handler/command/update_provider_command.dart';
import '../../../shared/providers/application/use_cases/handler/queries/get_provider_query.dart';
import '../../../shared/providers/infrastructure/adapters/provider_database_adapter.dart';
import '../../../shared/providers/ui/myProvider/provider_page.dart';
import '../../infrastructure/backup_manager.dart'; // Importa el BackupManager
import 'settings_main_page.dart'; // Importa SettingsMainPage

class SettingsPage extends StatelessWidget {
  final BackupManager backupManager;

  SettingsPage({required this.backupManager});

  @override
  Widget build(BuildContext context) {
    final ProviderSQLiteAdapter providerAdapter = ProviderSQLiteAdapter();
    final createProviderUseCase = CreateProviderCommand(providerAdapter);
    final updateProviderUseCase = UpdateProviderCommand(providerAdapter);
    final deleteProviderUseCase = DeleteProviderCommand(providerAdapter);
    final getProvidersUseCase = GetProvidersQuery(providerAdapter);

    final CategorySQLiteAdapter categoryAdapter = CategorySQLiteAdapter();
    final createCategoryUseCase = CreateCategoryCommand(categoryAdapter);
    final updateCategoryUseCase = UpdateCategoryCommand(categoryAdapter);
    final deleteCategoryUseCase = DeleteCategoryCommand(categoryAdapter);
    final getCategoriesUseCase = GetCategoriesQuery(categoryAdapter);

    final CurrencySQLiteAdapter currencyAdapter = CurrencySQLiteAdapter();
    final getCurrenciesUseCase = GetCurrenciesQuery(currencyAdapter);
    final getDefaultCurrencyUseCase = GetDefaultCurrencyQuery(currencyAdapter);
    final setDefaultCurrencyUseCase = SetDefaultCurrencyCommand(currencyAdapter);

    return Scaffold(
      body: SafeArea(
        child: Navigator(
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) => SettingsMainPage(
                  createProviderUseCase: createProviderUseCase,
                  updateProviderUseCase: updateProviderUseCase,
                  deleteProviderUseCase: deleteProviderUseCase,
                  getProvidersUseCase: getProvidersUseCase,
                  createCategoryUseCase: createCategoryUseCase,
                  updateCategoryUseCase: updateCategoryUseCase,
                  deleteCategoryUseCase: deleteCategoryUseCase,
                  getCategoriesUseCase: getCategoriesUseCase,
                  getCurrenciesUseCase: getCurrenciesUseCase,
                  getDefaultCurrencyUseCase: getDefaultCurrencyUseCase,
                  setDefaultCurrencyUseCase: setDefaultCurrencyUseCase,
                  backupManager: backupManager,
                );
                break;
              case '/categories':
                builder = (BuildContext context) => CategoryPage(
                  createCategoryUseCase: createCategoryUseCase,
                  updateCategoryUseCase: updateCategoryUseCase,
                  deleteCategoryUseCase: deleteCategoryUseCase,
                  getCategoriesUseCase: getCategoriesUseCase,
                );
                break;
              case '/providers':
                builder = (BuildContext context) => ProviderPage(
                  createProviderUseCase: createProviderUseCase,
                  updateProviderUseCase: updateProviderUseCase,
                  deleteProviderUseCase: deleteProviderUseCase,
                  getProvidersUseCase: getProvidersUseCase,
                );
                break;
              case '/currencies':
                builder = (BuildContext context) => CurrencyPage(
                  getCurrenciesUseCase: getCurrenciesUseCase,
                  getDefaultCurrencyUseCase: getDefaultCurrencyUseCase,
                  setDefaultCurrencyUseCase: setDefaultCurrencyUseCase,
                );
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ),
      ),
    );
  }
}
