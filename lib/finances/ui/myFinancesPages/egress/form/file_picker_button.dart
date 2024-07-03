import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerButtonEgress extends StatelessWidget {
  final Function(String) onFileSelected;

  FilePickerButtonEgress({required this.onFileSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final result = await FilePicker.platform.pickFiles();
        if (result != null) {
          onFileSelected(result.files.single.path!);
        }
      },
      child: Text('Adjuntar imagen/documento'),
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Colors.grey, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
