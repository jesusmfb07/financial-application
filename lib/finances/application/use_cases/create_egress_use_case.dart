import '../../domain/aggregates/egress_aggregate.dart';

abstract class CreateEgressEntryUseCase {
  Future<void> execute(EgressEntryAggregate aggregate);
}