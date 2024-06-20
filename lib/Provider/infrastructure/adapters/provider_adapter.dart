import '../../application/ports/provider_port.dart';
import '../../domain/entities/provider_entity.dart';

class ProviderAdapter implements ProviderPort {
  List<Provider> _providers = [];

  @override
  Future<List<Provider>> getProviders() async {
    return _providers;
  }

  @override
  Future<void> createProvider(Provider provider) async {
    _providers.add(provider);
  }

  @override
  Future<void> updateProvider(Provider provider) async {
    final index = _providers.indexWhere((c) => c.id == provider.id);
    if (index != -1) {
      _providers[index] = provider;
    }
  }

  @override
  Future<void> deleteProvider(String id) async {
    _providers.removeWhere((c) => c.id == id);
  }
}