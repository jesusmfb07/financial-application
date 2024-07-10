import 'package:flutter/material.dart';
import '../../../application/use_cases/get_egress_use_case.dart';
import '../../../domain/aggregates/egress_aggregate.dart';
import '../../../domain/entities/egress_entry_entity.dart';
import 'widgets/entry_tile.dart';

class EgressEntryList extends StatelessWidget {
  final GetEgressEntriesUseCase getEntriesUseCase;
  final Function(EgressEntry) onEdit;
  final Function(String) onViewAttachment;

  EgressEntryList({
    required this.getEntriesUseCase,
    required this.onEdit,
    required this.onViewAttachment,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EgressEntryAggregate>>(
      future: getEntriesUseCase.execute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay egreso'));
        } else {
          final egressEntries = snapshot.data!.map((aggregate) {
            return EgressEntry(
              id: aggregate.id,
              description: aggregate.description,
              amount: aggregate.amount,
              date: aggregate.date,
              category: aggregate.category,
              provider: aggregate.provider,
              attachmentPath: aggregate.attachmentPath,
              currencySymbol: aggregate.currencySymbol,
            );
          }).toList();

          return ListView.builder(
            itemCount: egressEntries.length,
            itemBuilder: (context, index) {
              final entry = egressEntries[index];
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
