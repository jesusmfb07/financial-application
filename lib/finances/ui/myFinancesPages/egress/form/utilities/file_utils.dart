import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> saveFileLocally(String filePath) async {
  final directory = await getApplicationDocumentsDirectory();
  final fileName = filePath.split('/').last;
  final localPath = '${directory.path}/$fileName';
  final localFile = await File(filePath).copy(localPath);
  return localFile.path;
}