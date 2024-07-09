import '../../domain/aggregates/provider_aggregate.dart';

abstract class DeleteProviderUseCase {
  Future<void> execute(ProviderAggregate providerAggregate);
}