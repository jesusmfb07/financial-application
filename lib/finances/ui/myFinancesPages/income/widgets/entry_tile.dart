import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/income_entry_entity.dart';
import 'attachment_viewer.dart';

class EntryTile extends StatelessWidget {
  final IncomeEntry entry;
  final Function(IncomeEntry) onEdit;
  final Function(String) onViewAttachment;

  EntryTile({
    required this.entry,
    required this.onEdit,
    required this.onViewAttachment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fecha: ${DateFormat('yyyy-MM-dd').format(entry.date)}',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => onEdit(entry),
              ),
            ],
          ),
          Text(
            'Monto: ${entry.currencySymbol}${entry.amount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Descripción: ${entry.description}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Categoría: ${entry.category}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          AttachmentViewer(attachmentPath: entry.attachmentPath),
        ],
      ),
    );
  }
}
