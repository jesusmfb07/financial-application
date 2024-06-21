// import '../entities/finance_entry.entity.dart';
//
// class FinanceEntryAggregate {
//   final List<FinanceEntry> entries;
//
//   FinanceEntryAggregate({required this.entries});
//
//   void createEntry(FinanceEntry entry) {
//     entries.add(entry);
//   }
//
//   void updateEntry(FinanceEntry entry) {
//     final index = entries.indexWhere((e) => e.description == entry.description);
//     if (index != -1) {
//       entries[index] = entry;
//     }
//   }
//
//   void deleteEntry(FinanceEntry entry) {
//     entries.removeWhere((e) => e.description == entry.description);
//   }
// }
