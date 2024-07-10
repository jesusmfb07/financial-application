// import 'dart:convert';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
//
//
// import '../../../finances/infrastructure/adapters/egress_adapter.dart';
// import '../../../finances/infrastructure/adapters/income_adapter.dart';
//
//   class BackupManager {
//   final IncomeEntrySQLiteAdapter incomeAdapter;
//   final EgressEntrySQLiteAdapter egressAdapter;
//
//   BackupManager({required this.incomeAdapter, required this.egressAdapter});
//
//   Future<String> exportData() async {
//     final incomeData = await incomeAdapter.getAllEntries();
//     final egressData = await egressAdapter.getAllEntries();
//
//     final backupData = {
//       'income': incomeData,
//       'egress': egressData,
//     };
//
//     final jsonString = jsonEncode(backupData);
//
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/backup.json');
//     await file.writeAsString(jsonString);
//
//     return file.path;
//   }
//
//   Future<void> importData(String filePath) async {
//     final file = File(filePath);
//     final jsonString = await file.readAsString();
//     final backupData = jsonDecode(jsonString);
//
//     final incomeData = backupData['income'];
//     final egressData = backupData['egress'];
//
//     await incomeAdapter.insertEntries(incomeData);
//     await egressAdapter.insertEntries(egressData);
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../../finances/infrastructure/adapters/egress_adapter.dart';
import '../../../finances/infrastructure/adapters/income_adapter.dart';

class BackupManager {
  final IncomeEntrySQLiteAdapter incomeAdapter;
  final EgressEntrySQLiteAdapter egressAdapter;

  BackupManager({required this.incomeAdapter, required this.egressAdapter});

  Future<String> exportData() async {
    final incomeData = await incomeAdapter.getAllEntries();
    final egressData = await egressAdapter.getAllEntries();

    // Export images
    final imageFiles = await _exportImages(incomeData + egressData);

    final backupData = {
      'income': incomeData,
      'egress': egressData,
      'images': imageFiles,
    };

    final jsonString = jsonEncode(backupData);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/backup.json');
    await file.writeAsString(jsonString);

    return file.path;
  }

  Future<void> importData(String filePath) async {
    final file = File(filePath);
    final jsonString = await file.readAsString();
    final backupData = jsonDecode(jsonString);

    final incomeData = backupData['income'];
    final egressData = backupData['egress'];
    final imageFiles = Map<String, String>.from(backupData['images']);

    await incomeAdapter.insertEntries(incomeData);
    await egressAdapter.insertEntries(egressData);

    // Import images
    await _importImages(imageFiles);
  }

  Future<Map<String, String>> _exportImages(List<Map<String, dynamic>> entries) async {
    final Map<String, String> imageFiles = {};
    final directory = await getApplicationDocumentsDirectory();

    for (var entry in entries) {
      final imagePath = entry['imagePath']; // Asegúrate de que 'imagePath' sea el campo correcto
      if (imagePath != null && File(imagePath).existsSync()) {
        final fileName = imagePath.split('/').last;
        final newFilePath = '${directory.path}/$fileName';
        await File(imagePath).copy(newFilePath);
        imageFiles[imagePath] = newFilePath;
      }
    }

    return imageFiles;
  }

  Future<void> _importImages(Map<String, String> imageFiles) async {
    for (var oldPath in imageFiles.keys) {
      final newPath = imageFiles[oldPath]!;
      await File(newPath).copy(oldPath);
    }
  }
}