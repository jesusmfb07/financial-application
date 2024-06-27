import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FileStorageService {
  Future<String> _getDirectoryPath() async {
    final directory = await getExternalStorageDirectory();
    final financeDir = Directory(path.join(directory!.path, 'FinanceApplication'));
    if (!await financeDir.exists()) {
      await financeDir.create(recursive: true);
    }
    return financeDir.path;
  }

  Future<File> saveFile(File file) async {
    final directoryPath = await _getDirectoryPath();
    final fileName = path.basename(file.path);
    final savedFile = File(path.join(directoryPath, fileName));
    return file.copy(savedFile.path);
  }
}