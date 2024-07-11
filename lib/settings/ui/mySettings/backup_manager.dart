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
// import 'dart:convert';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import '../../../finances/infrastructure/adapters/egress_adapter.dart';
// import '../../../finances/infrastructure/adapters/income_adapter.dart';
//
// class BackupManager {
//   final IncomeEntrySQLiteAdapter incomeAdapter;
//   final EgressEntrySQLiteAdapter egressAdapter;
//
//   BackupManager({required this.incomeAdapter, required this.egressAdapter});
//
//   Future<String> exportData() async {
//     final incomeData = await incomeAdapter.getAllEntries();
//     final egressData = await egressAdapter.getAllEntries();
//
//     // Export images
//     final imageFiles = await _exportImages(incomeData + egressData);
//
//     final backupData = {
//       'income': incomeData,
//       'egress': egressData,
//       'images': imageFiles,
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
//     final imageFiles = Map<String, String>.from(backupData['images']);
//
//     await incomeAdapter.insertEntries(incomeData);
//     await egressAdapter.insertEntries(egressData);
//
//     // Import images
//     await _importImages(imageFiles);
//   }
//
//   Future<Map<String, String>> _exportImages(List<Map<String, dynamic>> entries) async {
//     final Map<String, String> imageFiles = {};
//     final directory = await getApplicationDocumentsDirectory();
//
//     for (var entry in entries) {
//       final imagePath = entry['imagePath']; // Asegúrate de que 'imagePath' sea el campo correcto
//       if (imagePath != null && File(imagePath).existsSync()) {
//         final fileName = imagePath.split('/').last;
//         final newFilePath = '${directory.path}/$fileName';
//         await File(imagePath).copy(newFilePath);
//         imageFiles[imagePath] = newFilePath;
//       }
//     }
//
//     return imageFiles;
//   }
//
//   Future<void> _importImages(Map<String, String> imageFiles) async {
//     for (var oldPath in imageFiles.keys) {
//       final newPath = imageFiles[oldPath]!;
//       await File(newPath).copy(oldPath);
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import '../../../finances/infrastructure/adapters/egress_adapter.dart';
import '../../../finances/infrastructure/adapters/income_adapter.dart';


class BackupManager {
  final IncomeEntrySQLiteAdapter incomeAdapter;
  final EgressEntrySQLiteAdapter egressAdapter;

  BackupManager({required this.incomeAdapter, required this.egressAdapter});

  Future<String> exportData() async {
    final incomeData = await incomeAdapter.getAllEntries();
    final egressData = await egressAdapter.getAllEntries();

    final backupData = {
      'income': incomeData,
      'egress': egressData,
    };

    final jsonString = jsonEncode(backupData);

    final directory = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${directory.path}/backups');
    if (!backupDir.existsSync()) {
      backupDir.createSync();
    }
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final filePath = '${backupDir.path}/finanzas_$timestamp.zip';

    final zipEncoder = ZipFileEncoder();
    zipEncoder.create(filePath);
    zipEncoder.addFile(File('${backupDir.path}/data.json')..writeAsStringSync(jsonString));

    // Add images if any
    for (var entry in [...incomeData, ...egressData]) {
      if (entry['attachmentPath'] != null) {
        final file = File(entry['attachmentPath']);
        if (file.existsSync()) {
          zipEncoder.addFile(file);
        }
      }
    }

    zipEncoder.close();

    return filePath;
  }

  Future<void> importData(String filePath) async {
    final file = File(filePath);
    final bytes = file.readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);

    for (var file in archive) {
      final filename = file.name;
      if (filename == 'data.json') {
        final data = utf8.decode(file.content as List<int>);
        final backupData = jsonDecode(data);
        await _restoreData(backupData);
      } else {
        final outputFile = File((await getApplicationDocumentsDirectory()).path + '/' + filename);
        outputFile.createSync(recursive: true);
        outputFile.writeAsBytesSync(file.content as List<int>);
      }
    }
  }

  Future<void> _restoreData(Map<String, dynamic> data) async {
    final incomeData = List<Map<String, dynamic>>.from(data['income']);
    final egressData = List<Map<String, dynamic>>.from(data['egress']);

    await incomeAdapter.clearAllEntries();
    await egressAdapter.clearAllEntries();

    await incomeAdapter.insertEntries(incomeData);
    await egressAdapter.insertEntries(egressData);
  }
}



