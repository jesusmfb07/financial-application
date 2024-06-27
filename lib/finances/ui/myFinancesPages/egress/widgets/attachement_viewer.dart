import 'dart:io';
import 'package:flutter/material.dart';

class AttachmentViewer extends StatelessWidget {
  final String attachmentPath;
  final Function(String) onViewAttachment;

  AttachmentViewer({
    required this.attachmentPath,
    required this.onViewAttachment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onViewAttachment(attachmentPath),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: attachmentPath.toLowerCase().endsWith('.pdf')
              ? null
              : DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(File(attachmentPath)),
          ),
        ),
        child: attachmentPath.toLowerCase().endsWith('.pdf')
            ? Center(
          child: Icon(
            Icons.picture_as_pdf,
            size: 50,
            color: Colors.red,
          ),
        )
            : null,
      ),
    );
  }
}
