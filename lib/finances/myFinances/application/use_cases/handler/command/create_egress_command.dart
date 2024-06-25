import '../../../../domain/aggregates/egress_aggregate.dart';
import '../../../../domain/entities/egress_entry_entity.dart';
import '../../../ports/egress_port.dart';
import '../../egress_use_case.dart';

class CreateEgressEntryCommand implements CreateEgressEntryUseCase {
  final EgressEntryPort egressEntryPort;

  CreateEgressEntryCommand(this.egressEntryPort);

  @override
  Future<void> execute(EgressEntryAggregate aggregate, EgressEntry entry) async {
    aggregate.createEntry(entry);
    await egressEntryPort.createEntry(entry);
  }
}