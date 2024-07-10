import '../../../../domain/aggregates/egress_aggregate.dart';
import '../../../../domain/entities/egress_entry_entity.dart';
import '../../../ports/egress_port.dart';
import '../../create_egress_use_case.dart';
import '../../egress_use_case.dart';

class CreateEgressEntryCommand implements CreateEgressEntryUseCase {
  final EgressEntryPort egressEntryPort;

  CreateEgressEntryCommand(this.egressEntryPort);

  @override
  Future<void> execute(EgressEntryAggregate aggregate) async {
    // Conversión de EgressEntryAggregate a EgressEntry
    final entry = EgressEntry(
      id: aggregate.id,
      description: aggregate.description,
      amount: aggregate.amount,
      date: aggregate.date,
      category: aggregate.category,
      provider: aggregate.provider,
      attachmentPath: aggregate.attachmentPath,
      currencySymbol: aggregate.currencySymbol,
    );

    // Validaciones o cualquier lógica de negocio necesaria antes de crear la entrada
    if (entry.description.isEmpty) {
      throw Exception('La descripción no puede estar vacía');
    }

    await egressEntryPort.createEntry(entry);
  }
}