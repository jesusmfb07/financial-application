import 'dart:convert';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';

import '../../finances/infrastructure/adapters/egress_adapter.dart';
import '../../finances/infrastructure/adapters/income_adapter.dart';


class BackupManager {
  final IncomeEntrySQLiteAdapter incomeAdapter;
  final EgressEntrySQLiteAdapter egressAdapter;

  BackupManager({required this.incomeAdapter, required this.egressAdapter});

  Future<String> _generateJson() async {
    final incomeData = await incomeAdapter.getAllEntries();
    final egressData = await egressAdapter.getAllEntries();

    final backupData = {
      'income': incomeData,
      'egress': egressData,
    };

    return jsonEncode(backupData);
  }

  Future<String> _compressDataWithImages(String jsonString) async {
    final directory = await getExternalStorageDirectory();
    final backupDir = Directory('${directory!.path}/Download');
    if (!backupDir.existsSync()) {
      backupDir.createSync();
    }
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final filePath = '${backupDir.path}/finanzas_$timestamp.zip';

    final zipEncoder = ZipFileEncoder();
    zipEncoder.create(filePath);
    zipEncoder.addFile(File('${backupDir.path}/data.json')..writeAsStringSync(jsonString));

    final incomeData = await incomeAdapter.getAllEntries();
    final egressData = await egressAdapter.getAllEntries();

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

  Future<String> exportData() async {
    final jsonString = await _generateJson();
    return await _compressDataWithImages(jsonString);
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


