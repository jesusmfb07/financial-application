import '../../domain/entities/egress_entry_entity.dart';

abstract class EgressEntryPort {
  Future<void> createEntry(EgressEntry entry);
  Future<void> updateEntry(EgressEntry entry);
  Future<List<EgressEntry>> getEntries();
}