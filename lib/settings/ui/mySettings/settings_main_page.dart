import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../shared/categories/application/use_cases/handler/command/create_category_command.dart';
import '../../../shared/categories/application/use_cases/handler/command/delete_category_command.dart';
import '../../../shared/categories/application/use_cases/handler/command/update_category_command.dart';
import '../../../shared/categories/application/use_cases/handler/queries/get_categories_command.dart';
import '../../../shared/currencies/application/use_cases/handler/command/set_currency_command.dart';
import '../../../shared/currencies/application/use_cases/handler/queries/get_currency_query.dart';
import '../../../shared/currencies/application/use_cases/handler/queries/get_default_currency_query.dart';
import '../../../shared/providers/application/use_cases/handler/command/create_provider_command.dart';
import '../../../shared/providers/application/use_cases/handler/command/delete_provider_command.dart';
import '../../../shared/providers/application/use_cases/handler/command/update_provider_command.dart';
import '../../../shared/providers/application/use_cases/handler/queries/get_provider_query.dart';
import '../../infrastructure/backup_manager.dart';

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
    try {
      final filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip'],
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
