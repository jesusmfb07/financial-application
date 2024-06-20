import '../../domain/aggregates/provider_aggregate.dart';
import '../../domain/entities/provider_entity.dart';

abstract class ProviderPort {
  Future<void> createProvider(ProviderAggregate aggregate,Provider provider);
  Future<void> updateProvider(ProviderAggregate aggregate,Provider provider);
  Future<void> deleteProvider(String id);
  Future<List<Provider>> getProviders();
}
