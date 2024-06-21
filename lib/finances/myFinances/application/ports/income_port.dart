import '../../domain/entities/income_entry_entity.dart';

abstract class IncomeEntryPort {
  Future<void> createEntry(IncomeEntry entry);
  Future<void> updateEntry(IncomeEntry entry);
  Future<List<IncomeEntry>> getEntries();
}