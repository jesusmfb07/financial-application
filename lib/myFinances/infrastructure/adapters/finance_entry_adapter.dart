import '../../application/ports/finance_entry_port.dart';
import '../../domain/entities/finance_entry.entity.dart';

class FinanceEntryAdapter implements FinanceEntryPort {
  final _entries = <FinanceEntry>[];

  @override
  Future<void> createEntry(FinanceEntry entry) async {
    _entries.add(entry);
  }

  @override
  Stream<List<FinanceEntry>> getEntries() async* {
    yield _entries;
  }
}