import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import '../../egress/image_preview_page.dart';
import '../../egress/pdf_viewer_page.dart';

class AttachmentViewer extends StatelessWidget {
  final String? attachmentPath;

  AttachmentViewer({this.attachmentPath});

  @override
  Widget build(BuildContext context) {
    if (attachmentPath == null) {
      return Container(); // No se muestra nada si no hay archivo adjunto
    }

    if (attachmentPath!.toLowerCase().endsWith('.jpg') ||
        attachmentPath!.toLowerCase().endsWith('.jpeg') ||
        attachmentPath!.toLowerCase().endsWith('.png')) {
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePreviewPage(imagePath: attachmentPath!),
          ),
        ),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(attachmentPath!)),
            ),
          ),
        ),
      );
    } else if (attachmentPath!.toLowerCase().endsWith('.pdf')) {
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerPage(pdfPath: attachmentPath!),
          ),
        ),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.red[100],
          ),
          child: Center(
            child: Icon(
              Icons.picture_as_pdf,
              size: 50,
              color: Colors.red,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => OpenFile.open(attachmentPath!),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(Icons.insert_drive_file, color: Colors.grey[600]),
        ),
      );
    }
  }
}
