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

  // // Método adicional para obtener el total de ingresos
  // double getTotalIncome() {
  //   return entries.fold(0, (sum, entry) => sum + entry.amount);
  // }
  //
  // // Método opcional para obtener entradas por rango de fechas
  // List<IncomeEntry> getEntriesByDateRange(DateTime start, DateTime end) {
  //   return entries.where((entry) =>
  //   entry.date.isAfter(start) && entry.date.isBefore(end)
  //   ).toList();
  // }
}