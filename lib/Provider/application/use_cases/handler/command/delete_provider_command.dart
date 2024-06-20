import '../../../../domain/aggregates/provider_aggregate.dart';
import '../../../../domain/entities/provider_entity.dart';
import '../../../ports/provider_port.dart';
import '../../provider_use_case.dart';

class DeleteProviderCommand implements DeleteProviderUseCase {
  final ProviderPort providerPort;

  DeleteProviderCommand(this.providerPort);

  @override
  Future<void> execute(ProviderAggregate aggregate, Provider provider) async {
    await providerPort.deleteProvider(provider.id);
    aggregate.deleteProvider(provider);
  }
}