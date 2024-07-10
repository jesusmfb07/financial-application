import '../../../../domain/aggregates/provider_aggregate.dart';
import '../../../../domain/entities/provider_entity.dart';
import '../../../ports/provider_port.dart';
import '../../create_provider_use_case.dart';


class CreateProviderCommand implements CreateProviderUseCase {
  final ProviderPort providerPort;

  CreateProviderCommand(this.providerPort);

  @override
  Future<void> execute(ProviderAggregate providerAggregate) async {
    // Conversión de ProviderAggregate a Provider
    final provider = Provider(
      id: providerAggregate.id,
      name: providerAggregate.name,
      phoneNumber: providerAggregate.phoneNumber,
      ruc: providerAggregate.ruc,
    );

    // Validaciones o cualquier lógica de negocio necesaria antes de crear el proveedor
    if (provider.name.isEmpty) {
      throw Exception('El nombre del proveedor no puede estar vacío');
    }

    await providerPort.createProvider(provider);
  }
}