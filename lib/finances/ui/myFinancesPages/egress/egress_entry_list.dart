import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../application/use_cases/egress_use_case.dart';
import '../../../domain/aggregates/egress_aggregate.dart';
import '../../../domain/entities/egress_entry_entity.dart';
import 'widgets/entry_tile.dart';

class EgressEntryList extends StatelessWidget {
  final GetEgressEntriesUseCase getEntriesUseCase;
  final EgressEntryAggregate aggregate;
  final Function(EgressEntry) onEdit;
  final Function(String) onViewAttachment;

  EgressEntryList({
    required this.getEntriesUseCase,
    required this.aggregate,
    required this.onEdit,
    required this.onViewAttachment,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EgressEntry>>(
      future: getEntriesUseCase.execute(aggregate),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay egreso'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final entry = snapshot.data![index];
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
