import '../../domain/aggregates/provider_aggregate.dart';

abstract class CreateProviderUseCase {
  Future<void> execute(ProviderAggregate providerAggregate);
}