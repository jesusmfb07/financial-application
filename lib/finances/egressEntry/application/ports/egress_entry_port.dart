import '../../domain/entities/egress_entry_entity.dart';

abstract class EgressEntryPort {
  Future<List<EgressEntry>> getEntries();
  Future<void> createEntry(EgressEntry entry);
  Future<void> updateEntry(EgressEntry entry);
  Future<void> deleteEntry(String id);
}