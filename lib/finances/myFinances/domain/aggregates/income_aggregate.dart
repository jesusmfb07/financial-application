import '../entities/income_entry_entity.dart';

class IncomeEntryAggregate {
  final List<IncomeEntry> entries;

  IncomeEntryAggregate({required this.entries});

  void createEntry(IncomeEntry entry) {
    entries.add(entry);
  }

  void updateEntry(IncomeEntry entry) {
    final index = entries.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      entries[index] = entry;
    }
  }
}