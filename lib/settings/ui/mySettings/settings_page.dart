// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../shared/categories/application/use_cases/handler/command/create_category_command.dart';
// import '../../../shared/categories/application/use_cases/handler/command/delete_category_command.dart';
// import '../../../shared/categories/application/use_cases/handler/command/update_category_command.dart';
// import '../../../shared/categories/application/use_cases/handler/queries/get_categories_command.dart';
// import '../../../shared/categories/infrastructure/adapters/category_sqlite_adapter.dart';
// import '../../../shared/categories/ui/myCategory/category_page.dart';
// import '../../../shared/currencies/application/use_cases/handler/command/set_currency_command.dart';
// import '../../../shared/currencies/application/use_cases/handler/queries/get_currency_query.dart';
// import '../../../shared/currencies/application/use_cases/handler/queries/get_default_currency_query.dart';
// import '../../../shared/currencies/infrastructure/adapters/currency_adapter.dart';
// import '../../../shared/currencies/ui/currency_page.dart';
// import '../../../shared/providers/application/use_cases/handler/command/create_provider_command.dart';
// import '../../../shared/providers/application/use_cases/handler/command/delete_provider_command.dart';
// import '../../../shared/providers/application/use_cases/handler/command/update_provider_command.dart';
// import '../../../shared/providers/application/use_cases/handler/queries/get_provider_query.dart';
// import '../../../shared/providers/infrastructure/adapters/provider_database_adapter.dart';
// import '../../../shared/providers/ui/myProvider/provider_page.dart';
//
//
// class SettingsPage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     final ProviderSQLiteAdapter providerAdapter = ProviderSQLiteAdapter();
//     final createProviderUseCase = CreateProviderCommand(providerAdapter);
//     final updateProviderUseCase = UpdateProviderCommand(providerAdapter);
//     final deleteProviderUseCase = DeleteProviderCommand(providerAdapter);
//     final getProvidersUseCase = GetProvidersQuery(providerAdapter);
//
//     final CategorySQLiteAdapter categoryAdapter = CategorySQLiteAdapter();
//     final createCategoryUseCase = CreateCategoryCommand(categoryAdapter);
//     final updateCategoryUseCase = UpdateCategoryCommand(categoryAdapter);
//     final deleteCategoryUseCase = DeleteCategoryCommand(categoryAdapter);
//     final getCategoriesUseCase = GetCategoriesQuery(categoryAdapter);
//
//     final CurrencySQLiteAdapter currencyAdapter = CurrencySQLiteAdapter();
//     final getCurrenciesUseCase = GetCurrenciesQuery(currencyAdapter);
//     final getDefaultCurrencyUseCase = GetDefaultCurrencyQuery(currencyAdapter);
//     final setDefaultCurrencyUseCase = SetDefaultCurrencyCommand(currencyAdapter);
//
//     String formattedDate = DateFormat('dd/MM/yy').format(DateTime.now());
//
//     return Scaffold(
//       body: SafeArea(
//         child: Navigator(
//           onGenerateRoute: (RouteSettings settings) {
//             WidgetBuilder builder;
//             switch (settings.name) {
//               case '/':
//                 builder = (BuildContext context) => SettingsMainPage(
//                   createProviderUseCase: createProviderUseCase,
//                   updateProviderUseCase: updateProviderUseCase,
//                   deleteProviderUseCase: deleteProviderUseCase,
//                   getProvidersUseCase: getProvidersUseCase,
//                   createCategoryUseCase: createCategoryUseCase,
//                   updateCategoryUseCase: updateCategoryUseCase,
//                   deleteCategoryUseCase: deleteCategoryUseCase,
//                   getCategoriesUseCase: getCategoriesUseCase,
//                   getCurrenciesUseCase: getCurrenciesUseCase,
//                   getDefaultCurrencyUseCase: getDefaultCurrencyUseCase,
//                   setDefaultCurrencyUseCase: setDefaultCurrencyUseCase,
//                 );
//                 break;
//               case '/categories':
//                 builder = (BuildContext context) => CategoryPage(
//                   createCategoryUseCase: createCategoryUseCase,
//                   updateCategoryUseCase: updateCategoryUseCase,
//                   deleteCategoryUseCase: deleteCategoryUseCase,
//                   getCategoriesUseCase: getCategoriesUseCase,
//                 );
//                 break;
//               case '/providers':
//                 builder = (BuildContext context) => ProviderPage(
//                   createProviderUseCase: createProviderUseCase,
//                   updateProviderUseCase: updateProviderUseCase,
//                   deleteProviderUseCase: deleteProviderUseCase,
//                   getProvidersUseCase: getProvidersUseCase,
//                 );
//                 break;
//               case '/currencies':
//                 builder = (BuildContext context) => CurrencyPage(
//                   getCurrenciesUseCase: getCurrenciesUseCase,
//                   getDefaultCurrencyUseCase: getDefaultCurrencyUseCase,
//                   setDefaultCurrencyUseCase: setDefaultCurrencyUseCase,
//                 );
//                 break;
//               default:
//                 throw Exception('Invalid route: ${settings.name}');
//             }
//             return MaterialPageRoute(builder: builder, settings: settings);
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class SettingsMainPage extends StatelessWidget {
//   final CreateProviderCommand createProviderUseCase;
//   final UpdateProviderCommand updateProviderUseCase;
//   final DeleteProviderCommand deleteProviderUseCase;
//   final GetProvidersQuery getProvidersUseCase;
//
//   final CreateCategoryCommand createCategoryUseCase;
//   final UpdateCategoryCommand updateCategoryUseCase;
//   final DeleteCategoryCommand deleteCategoryUseCase;
//   final GetCategoriesQuery getCategoriesUseCase;
//
//   final GetCurrenciesQuery getCurrenciesUseCase;
//   final GetDefaultCurrencyQuery getDefaultCurrencyUseCase;
//   final SetDefaultCurrencyCommand setDefaultCurrencyUseCase;
//
//   SettingsMainPage({
//     required this.createProviderUseCase,
//     required this.updateProviderUseCase,
//     required this.deleteProviderUseCase,
//     required this.getProvidersUseCase,
//     required this.createCategoryUseCase,
//     required this.updateCategoryUseCase,
//     required this.deleteCategoryUseCase,
//     required this.getCategoriesUseCase,
//     required this.getCurrenciesUseCase,
//     required this.getDefaultCurrencyUseCase,
//     required this.setDefaultCurrencyUseCase,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     String formattedDate = DateFormat('dd/MM/yy').format(DateTime.now());
//
//     return Column(
//       children: [
//         Container(
//           color: Colors.teal,
//           padding: EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: Icon(
//                   Icons.settings,
//                   color: Colors.teal,
//                   size: 24,
//                 ),
//               ),
//               SizedBox(width: 16.0),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Ajustes',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     formattedDate,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ],
//               ),
//               Spacer(),
//             ],
//           ),
//         ),
//         Expanded(
//           child: ListView(
//             children: [
//               ListTile(
//                 leading: Icon(Icons.folder),
//                 title: Text('Recordatorios'),
//                 trailing: Icon(Icons.chevron_right),
//                 onTap: () async {
//                   // Implementación para Recordatorios
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.category),
//                 title: Text('Categorías'),
//                 trailing: Icon(Icons.chevron_right),
//                 onTap: () {
//                   Navigator.pushNamed(context, '/categories');
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.business),
//                 title: Text('Proveedores'),
//                 trailing: Icon(Icons.chevron_right),
//                 onTap: () {
//                   Navigator.pushNamed(context, '/providers');
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.attach_money),
//                 title: Text('Monedas'),
//                 trailing: Icon(Icons.chevron_right),
//                 onTap: () {
//                   Navigator.pushNamed(context, '/currencies');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../shared/categories/application/use_cases/handler/command/create_category_command.dart';
// import '../../../shared/categories/application/use_cases/handler/command/delete_category_command.dart';
// import '../../../shared/categories/application/use_cases/handler/command/update_category_command.dart';
// import '../../../shared/categories/application/use_cases/handler/queries/get_categories_command.dart';
// import '../../../shared/categories/infrastructure/adapters/category_sqlite_adapter.dart';
// import '../../../shared/categories/ui/myCategory/category_page.dart';
// import '../../../shared/currencies/application/use_cases/handler/command/set_currency_command.dart';
// import '../../../shared/currencies/application/use_cases/handler/queries/get_currency_query.dart';
// import '../../../shared/currencies/application/use_cases/handler/queries/get_default_currency_query.dart';
// import '../../../shared/currencies/infrastructure/adapters/currency_adapter.dart';
// import '../../../shared/currencies/ui/currency_page.dart';
// import '../../../shared/providers/application/use_cases/handler/command/create_provider_command.dart';
// import '../../../shared/providers/application/use_cases/handler/command/delete_provider_command.dart';
// import '../../../shared/providers/application/use_cases/handler/command/update_provider_command.dart';
// import '../../../shared/providers/application/use_cases/handler/queries/get_provider_query.dart';
// import '../../../shared/providers/infrastructure/adapters/provider_database_adapter.dart';
// import '../../../shared/providers/ui/myProvider/provider_page.dart';
//
//
// class SettingsPage extends StatelessWidget {
//   final BackupManager backupManager; // Añadido para el BackupManager
//
//   SettingsPage({required this.backupManager}); // Añadido para el BackupManager
//
//   @override
//   Widget build(BuildContext context) {
//     final ProviderSQLiteAdapter providerAdapter = ProviderSQLiteAdapter();
//     final createProviderUseCase = CreateProviderCommand(providerAdapter);
//     final updateProviderUseCase = UpdateProviderCommand(providerAdapter);
//     final deleteProviderUseCase = DeleteProviderCommand(providerAdapter);
//     final getProvidersUseCase = GetProvidersQuery(providerAdapter);
//
//     final CategorySQLiteAdapter categoryAdapter = CategorySQLiteAdapter();
//     final createCategoryUseCase = CreateCategoryCommand(categoryAdapter);
//     final updateCategoryUseCase = UpdateCategoryCommand(categoryAdapter);
//     final deleteCategoryUseCase = DeleteCategoryCommand(categoryAdapter);
//     final getCategoriesUseCase = GetCategoriesQuery(categoryAdapter);
//
//     final CurrencySQLiteAdapter currencyAdapter = CurrencySQLiteAdapter();
//     final getCurrenciesUseCase = GetCurrenciesQuery(currencyAdapter);
//     final getDefaultCurrencyUseCase = GetDefaultCurrencyQuery(currencyAdapter);
//     final setDefaultCurrencyUseCase = SetDefaultCurrencyCommand(currencyAdapter);
//
//     String formattedDate = DateFormat('dd/MM/yy').format(DateTime.now());
//
//     return Scaffold(
//       body: SafeArea(
//         child: Navigator(
//           onGenerateRoute: (RouteSettings settings) {
//             WidgetBuilder builder;
//             switch (settings.name) {
//               case '/':
//                 builder = (BuildContext context) => SettingsMainPage(
//                   createProviderUseCase: createProviderUseCase,
//                   updateProviderUseCase: updateProviderUseCase,
//                   deleteProviderUseCase: deleteProviderUseCase,
//                   getProvidersUseCase: getProvidersUseCase,
//                   createCategoryUseCase: createCategoryUseCase,
//                   updateCategoryUseCase: updateCategoryUseCase,
//                   deleteCategoryUseCase: deleteCategoryUseCase,
//                   getCategoriesUseCase: getCategoriesUseCase,
//                   getCurrenciesUseCase: getCurrenciesUseCase,
//                   getDefaultCurrencyUseCase: getDefaultCurrencyUseCase,
//                   setDefaultCurrencyUseCase: setDefaultCurrencyUseCase,
//                   backupManager: backupManager, // Añadido para el BackupManager
//                 );
//                 break;
//               case '/categories':
//                 builder = (BuildContext context) => CategoryPage(
//                   createCategoryUseCase: createCategoryUseCase,
//                   updateCategoryUseCase: updateCategoryUseCase,
//                   deleteCategoryUseCase: deleteCategoryUseCase,
//                   getCategoriesUseCase: getCategoriesUseCase,
//                 );
//                 break;
//               case '/providers':
//                 builder = (BuildContext context) => ProviderPage(
//                   createProviderUseCase: createProviderUseCase,
//                   updateProviderUseCase: updateProviderUseCase,
//                   deleteProviderUseCase: deleteProviderUseCase,
//                   getProvidersUseCase: getProvidersUseCase,
//                 );
//                 break;
//               case '/currencies':
//                 builder = (BuildContext context) => CurrencyPage(
//                   getCurrenciesUseCase: getCurrenciesUseCase,
//                   getDefaultCurrencyUseCase: getDefaultCurrencyUseCase,
//                   setDefaultCurrencyUseCase: setDefaultCurrencyUseCase,
//                 );
//                 break;
//               default:
//                 throw Exception('Invalid route: ${settings.name}');
//             }
//             return MaterialPageRoute(builder: builder, settings: settings);
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class SettingsMainPage extends StatelessWidget {
//   final CreateProviderCommand createProviderUseCase;
//   final UpdateProviderCommand updateProviderUseCase;
//   final DeleteProviderCommand deleteProviderUseCase;
//   final GetProvidersQuery getProvidersUseCase;
//
//   final CreateCategoryCommand createCategoryUseCase;
//   final UpdateCategoryCommand updateCategoryUseCase;
//   final DeleteCategoryCommand deleteCategoryUseCase;
//   final GetCategoriesQuery getCategoriesUseCase;
//
//   final GetCurrenciesQuery getCurrenciesUseCase;
//   final GetDefaultCurrencyQuery getDefaultCurrencyUseCase;
//   final SetDefaultCurrencyCommand setDefaultCurrencyUseCase;
//
//   final BackupManager backupManager; // Añadido para el BackupManager
//
//   SettingsMainPage({
//     required this.createProviderUseCase,
//     required this.updateProviderUseCase,
//     required this.deleteProviderUseCase,
//     required this.getProvidersUseCase,
//     required this.createCategoryUseCase,
//     required this.updateCategoryUseCase,
//     required this.deleteCategoryUseCase,
//     required this.getCategoriesUseCase,
//     required this.getCurrenciesUseCase,
//     required this.getDefaultCurrencyUseCase,
//     required this.setDefaultCurrencyUseCase,
//     required this.backupManager, // Añadido para el BackupManager
//   });
//
//   void _backupData(BuildContext context) async {
//     try {
//       final backupPath = await backupManager.exportData();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Respaldo guardado en: $backupPath')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error al realizar el respaldo: $e')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String formattedDate = DateFormat('dd/MM/yy').format(DateTime.now());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ajustes'),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Center(
//               child: Text(
//                 'Versión 0.01',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.backup),
//             onPressed: () => _backupData(context),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: Colors.teal,
//             padding: EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: Icon(
//                     Icons.settings,
//                     color: Colors.teal,
//                     size: 24,
//                   ),
//                 ),
//                 SizedBox(width: 16.0),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Ajustes',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       formattedDate,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.folder),
//                   title: Text('Recordatorios'),
//                   trailing: Icon(Icons.chevron_right),
//                   onTap: () async {
//                     // Implementación para Recordatorios
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.category),
//                   title: Text('Categorías'),
//                   trailing: Icon(Icons.chevron_right),
//                   onTap: () {
//                     Navigator.pushNamed(context, '/categories');
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.business),
//                   title: Text('Proveedores'),
//                   trailing: Icon(Icons.chevron_right),
//                   onTap: () {
//                     Navigator.pushNamed(context, '/providers');
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.attach_money),
//                   title: Text('Monedas'),
//                   trailing: Icon(Icons.chevron_right),
//                   onTap: () {
//                     Navigator.pushNamed(context, '/currencies');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// settings_page.dart

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

import 'backup_manager.dart'; // Importa el BackupManager

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

class SettingsMainPage extends StatelessWidget {
  final CreateProviderCommand createProviderUseCase;
  final UpdateProviderCommand updateProviderUseCase;
  final DeleteProviderCommand deleteProviderUseCase;
  final GetProvidersQuery getProvidersUseCase;

  final CreateCategoryCommand createCategoryUseCase;
  final UpdateCategoryCommand updateCategoryUseCase;
  final DeleteCategoryCommand deleteCategoryUseCase;
  final GetCategoriesQuery getCategoriesUseCase;

  final GetCurrenciesQuery getCurrenciesUseCase;
  final GetDefaultCurrencyQuery getDefaultCurrencyUseCase;
  final SetDefaultCurrencyCommand setDefaultCurrencyUseCase;

  final BackupManager backupManager;

  SettingsMainPage({
    required this.createProviderUseCase,
    required this.updateProviderUseCase,
    required this.deleteProviderUseCase,
    required this.getProvidersUseCase,
    required this.createCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
    required this.getCategoriesUseCase,
    required this.getCurrenciesUseCase,
    required this.getDefaultCurrencyUseCase,
    required this.setDefaultCurrencyUseCase,
    required this.backupManager,
  });

  void _backupData(BuildContext context) async {
    try {
      final backupPath = await backupManager.exportData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Respaldo guardado en: $backupPath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al realizar el respaldo: $e')),
      );
    }
  }

  void _restoreData(BuildContext context) async {
    // Implementa la lógica para seleccionar el archivo de respaldo y restaurar datos
    try {
      final filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (filePickerResult != null && filePickerResult.files.single.path != null) {
        final filePath = filePickerResult.files.single.path!;
        await backupManager.importData(filePath);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Datos restaurados correctamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se seleccionó ningún archivo')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al restaurar datos: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.settings,
                color: Colors.teal,
                size: 24,
              ),
            ),
            SizedBox(width: 16.0),
            Text(
              'Ajustes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  'Versión 0.001',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.backup, color: Colors.white),
              onPressed: () => _backupData(context),
            ),
            IconButton(
              icon: Icon(Icons.restore, color: Colors.white),
              onPressed: () => _restoreData(context),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.folder),
                  title: Text('Recordatorios'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () async {
                    // Implementación para Recordatorios
                  },
                ),
                ListTile(
                  leading: Icon(Icons.category),
                  title: Text('Categorías'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/categories');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.business),
                  title: Text('Proveedores'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/providers');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.attach_money),
                  title: Text('Monedas'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/currencies');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

