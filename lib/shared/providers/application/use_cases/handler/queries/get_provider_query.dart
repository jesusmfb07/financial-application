import '../../../../domain/aggregates/provider_aggregate.dart';
import '../../../../domain/entities/provider_entity.dart';
import '../../../ports/provider_port.dart';
import '../../get_providers_use_case.dart';

class GetProvidersQuery implements GetProvidersUseCase {
  final ProviderPort providerPort;

  GetProvidersQuery(this.providerPort);

  @override
  Future<List<ProviderAggregate>> execute() async {
    final providers = await providerPort.getProviders();
    // Convertir la lista de Provider a ProviderAggregate
    return providers.map((provider) => Provider(
      id: provider.id,
      name: provider.name,
      phoneNumber: provider.phoneNumber,
      ruc: provider.ruc,
    )).toList();
  }
}