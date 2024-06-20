import '../../../../domain/aggregates/provider_aggregate.dart';
import '../../../../domain/entities/provider_entity.dart';
import '../../../ports/provider_port.dart';
import '../../provider_use_case.dart';

class CreateProviderCommand implements CreateProviderUseCase {
  final ProviderPort providerPort;

  CreateProviderCommand(this.providerPort);

  @override
  Future<void> execute(ProviderAggregate aggregate, Provider provider) async {
    aggregate.createProvider(provider);
    await providerPort.createProvider(provider);
  }
}