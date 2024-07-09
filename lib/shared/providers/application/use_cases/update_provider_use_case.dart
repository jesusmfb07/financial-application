import '../../domain/aggregates/provider_aggregate.dart';

abstract class UpdateProviderUseCase {
  Future<void> execute(ProviderAggregate providerAggregate);
}