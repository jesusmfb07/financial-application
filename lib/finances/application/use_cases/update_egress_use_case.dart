import '../../domain/aggregates/egress_aggregate.dart';

abstract class UpdateEgressEntryUseCase {
  Future<void> execute(EgressEntryAggregate aggregate);
}