import '../../domain/aggregates/egress_aggregate.dart';

abstract class GetEgressEntriesUseCase {
  Future<List<EgressEntryAggregate>> execute();
}
