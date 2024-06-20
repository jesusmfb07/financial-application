import '../../domain/entities/provider_entity.dart';

abstract class ProviderPort {
  Future<void> createProvider(Provider provider);
  Future<void> updateProvider(Provider provider);
  Future<void> deleteProvider(String id);
  Future<List<Provider>> getProviders();
}