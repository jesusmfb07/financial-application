import '../../../../domain/aggregates/egress_aggregate.dart';
import '../../../../domain/entities/egress_entry_entity.dart';
import '../../../ports/egress_port.dart';
import '../../egress_use_case.dart';

class UpdateEgressEntryCommand implements UpdateEgressEntryUseCase {
  final EgressEntryPort egressEntryPort;

  UpdateEgressEntryCommand(this.egressEntryPort);

  @override
  Future<void> execute(EgressEntryAggregate aggregate, EgressEntry entry) async {
    aggregate.updateEntry(entry);
    await egressEntryPort.updateEntry(entry);
  }
}