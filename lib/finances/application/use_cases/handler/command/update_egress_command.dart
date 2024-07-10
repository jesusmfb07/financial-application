import '../../../../domain/aggregates/egress_aggregate.dart';
import '../../../../domain/entities/egress_entry_entity.dart';
import '../../../ports/egress_port.dart';
import '../../egress_use_case.dart';
import '../../update_egress_use_case.dart';

class UpdateEgressEntryCommand implements UpdateEgressEntryUseCase {
  final EgressEntryPort egressEntryPort;

  UpdateEgressEntryCommand(this.egressEntryPort);

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

    // Aquí puedes realizar validaciones si es necesario
    await egressEntryPort.updateEntry(entry);
  }
}