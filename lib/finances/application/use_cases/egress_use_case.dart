import '../../domain/aggregates/egress_aggregate.dart';
import '../../domain/entities/egress_entry_entity.dart';



abstract class CreateEgressEntryUseCase {
  Future<void> execute(EgressEntryAggregate aggregate, EgressEntry entry);
}

abstract class UpdateEgressEntryUseCase {
  Future<void> execute(EgressEntryAggregate aggregate, EgressEntry entry);
}