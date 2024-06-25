import '../entities/egress_entry_entity.dart';

class EgressEntryAggregate {
  final List<EgressEntry> entries;

  EgressEntryAggregate({required this.entries});

  void createEntry(EgressEntry entry) {
    entries.add(entry);
  }

  void updateEntry(EgressEntry entry) {
    final index = entries.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      entries[index] = entry;
    }
  }

  // void deleteEntry(String id) {
  //   entries.removeWhere((e) => e.id == id);
  // }
  //
  // List<EgressEntry> getEntries() {
  //   return entries;
  // }
}