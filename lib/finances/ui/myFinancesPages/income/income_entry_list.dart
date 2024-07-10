import 'package:flutter/material.dart';
import '../../../application/use_cases/get_income_use_case.dart';
import '../../../domain/aggregates/income_aggregate.dart';
import '../../../domain/entities/income_entry_entity.dart';
import 'widgets/entry_tile.dart';

class IncomeEntryList extends StatelessWidget {
  final GetIncomeEntriesUseCase getEntriesUseCase;
  final Function(IncomeEntry) onEdit;
  final Function(String) onViewAttachment;

  IncomeEntryList({
    required this.getEntriesUseCase,
    required this.onEdit,
    required this.onViewAttachment,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IncomeEntryAggregate>>(
      future: getEntriesUseCase.execute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay ingreso'));
        } else {
          final incomeEntries = snapshot.data!.map((aggregate) {
            return IncomeEntry(
              id: aggregate.id,
              description: aggregate.description,
              amount: aggregate.amount,
              date: aggregate.date,
              category: aggregate.category,
              attachmentPath: aggregate.attachmentPath,
              currencySymbol: aggregate.currencySymbol,
            );
          }).toList();

          return ListView.builder(
            itemCount: incomeEntries.length,
            itemBuilder: (context, index) {
              final entry = incomeEntries[index];
              return EntryTile(
                entry: entry,
                onEdit: onEdit,
                onViewAttachment: onViewAttachment,
              );
            },
          );
        }
      },
    );
  }
}
