// import '../entities/egress_entry_entity.dart';
//
// class EgressEntryAggregate {
//   final List<EgressEntry> entries;
//
//   EgressEntryAggregate({required this.entries});
//
//   void createEntry(EgressEntry entry) {
//     entries.add(entry);
//   }
//
//   void updateEntry(EgressEntry entry) {
//     final index = entries.indexWhere((e) => e.id == entry.id);
//     if (index != -1) {
//       entries[index] = entry;
//     }
//   }
// }

abstract class EgressEntryAggregate {
  int? get id;
  String get description;
  double get amount;
  DateTime get date;
  String? get category;
  String? get provider;
  String? get attachmentPath;
  String get currencySymbol;
}