// import '../../../../domain/aggregates/provider_aggregate.dart';
// import '../../../../domain/entities/provider_entity.dart';
// import '../../../ports/provider_port.dart';
// import '../../provider_use_case.dart';
//
// class UpdateProviderCommand implements UpdateProviderUseCase {
//   final ProviderPort providerPort;
//
//   UpdateProviderCommand(this.providerPort);
//
//   @override
//   Future<void> execute(ProviderAggregate aggregate, Provider provider) async {
//     aggregate.updateProvider(provider);
//     await providerPort.updateProvider(provider);
//   }
// }
//
//
import '../../../../domain/aggregates/provider_aggregate.dart';
import '../../../../domain/entities/provider_entity.dart';
import '../../../ports/provider_port.dart';
import '../../provider_use_case.dart';

class UpdateProviderCommand implements UpdateProviderUseCase {
  final ProviderPort providerPort;

  UpdateProviderCommand(this.providerPort);

  @override
  Future<void> execute(ProviderAggregate providerAggregate) async {
    // Conversión de ProviderAggregate a Provider
    final provider = Provider(
      id: providerAggregate.id,
      name: providerAggregate.name,
      phoneNumber: providerAggregate.phoneNumber,
      ruc: providerAggregate.ruc,
    );

    // Aquí puedes realizar validaciones si es necesario
    await providerPort.updateProvider(provider);
  }
}