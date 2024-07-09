// import '../../../../domain/aggregates/provider_aggregate.dart';
// import '../../../../domain/entities/provider_entity.dart';
// import '../../../ports/provider_port.dart';
// import '../../provider_use_case.dart';
//
// class DeleteProviderCommand implements DeleteProviderUseCase {
//   final ProviderPort providerPort;
//
//   DeleteProviderCommand(this.providerPort);
//
//   @override
//   Future<void> execute(ProviderAggregate aggregate, Provider provider) async {
//     aggregate.deleteProvider(provider);
//     await providerPort.deleteProvider(provider.id);
//   }
// }

import '../../../../domain/aggregates/provider_aggregate.dart';
import '../../../ports/provider_port.dart';
import '../../delete_provider_use_case.dart';

class DeleteProviderCommand implements DeleteProviderUseCase {
  final ProviderPort providerPort;

  DeleteProviderCommand(this.providerPort);

  @override
  Future<void> execute(ProviderAggregate providerAggregate) async {
    // Aquí puedes realizar validaciones si es necesario
    await providerPort.deleteProvider(providerAggregate.id);
  }
}