import '../entities/provider_entity.dart';

class ProviderAggregate {
  final List<Provider> providers;

  ProviderAggregate({required this.providers});

  void createProvider(Provider provider) {
    providers.add(provider);
  }

  void updateProvider(Provider provider) {
    final index = providers.indexWhere((p) => p.id == provider.id);
    if (index != -1) {
      providers[index] = provider;
    }
  }

  void deleteProvider(Provider provider) {
    providers.removeWhere((p) => p.id == provider.id);
  }
}


