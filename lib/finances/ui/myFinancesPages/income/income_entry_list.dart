import 'package:flutter/material.dart';
import '../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../application/use_cases/income_use_case.dart';
import '../../../domain/aggregates/income_aggregate.dart';
import '../../../domain/entities/income_entry_entity.dart';
import 'widgets/entry_tile.dart';

class IncomeEntryList extends StatelessWidget {
  final GetIncomeEntriesUseCase getEntriesUseCase;
  final IncomeEntryAggregate aggregate;
  final Function(IncomeEntry) onEdit;
  final Function(String) onViewAttachment;


  IncomeEntryList({
    required this.getEntriesUseCase,
    required this.aggregate,
    required this.onEdit,
    required this.onViewAttachment,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IncomeEntry>>(
      future: getEntriesUseCase.execute(aggregate),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay ingreso'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final entry = snapshot.data![index];
              return EntryTile(
                  entry: entry,
               onEdit: onEdit,
                onViewAttachment: onViewAttachment,);
            },
          );
        }
      },
    );
  }
}
