import '../../../../domain/aggregates/egress_aggregate.dart';
import '../../../../domain/entities/egress_entry_entity.dart';
import '../../../ports/egress_port.dart';
import '../../get_egress_use_case.dart';

class GetEgressEntriesQuery implements GetEgressEntriesUseCase {
  final EgressEntryPort egressEntryPort;

  GetEgressEntriesQuery(this.egressEntryPort);

  @override
  Future<List<EgressEntry>> execute(EgressEntryAggregate aggregate) async {
    return await egressEntryPort.getEntries();
  }
}