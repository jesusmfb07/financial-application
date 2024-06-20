import '../../../../domain/aggregates/provider_aggregate.dart';
import '../../../../domain/entities/provider_entity.dart';
import '../../../ports/provider_port.dart';
import '../../provider_use_case.dart';

class GetProvidersQuery implements GetProvidersUseCase {
  final ProviderPort providerPort;

  GetProvidersQuery(this.providerPort);

  @override
  Future<List<Provider>> execute(ProviderAggregate aggregate) async {
    return await providerPort.getProviders();
  }
}