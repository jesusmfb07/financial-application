import '../../domain/aggregates/egress_aggregate.dart';
import '../../domain/entities/egress_entry_entity.dart';

abstract class GetEgressEntriesUseCase {
  Future<List<EgressEntry>> execute(EgressEntryAggregate aggregate);
}