import '../../../../domain/aggregates/egress_aggregate.dart';
import '../../../../domain/entities/egress_entry_entity.dart';
import '../../../ports/egress_port.dart';
import '../../get_egress_use_case.dart';

class GetEgressEntriesQuery implements GetEgressEntriesUseCase {
  final EgressEntryPort egressEntryPort;

  GetEgressEntriesQuery(this.egressEntryPort);

  @override
  Future<List<EgressEntryAggregate>> execute() async {
    final entries = await egressEntryPort.getEntries();
    // Convertir la lista de EgressEntry a EgressEntryAggregate
    return entries.map((entry) => EgressEntry(
      id: entry.id,
      description: entry.description,
      amount: entry.amount,
      date: entry.date,
      category: entry.category,
      provider: entry.provider,
      attachmentPath: entry.attachmentPath,
      currencySymbol: entry.currencySymbol,
    )).toList();
  }
}