import '../../../../domain/aggregates/income_aggregate.dart';
import '../../../../domain/entities/income_entry_entity.dart';
import '../../../ports/income_port.dart';
import '../../create_income_use_case.dart';

class CreateIncomeEntryCommand implements CreateIncomeEntryUseCase {
  final IncomeEntryPort incomeEntryPort;

  CreateIncomeEntryCommand(this.incomeEntryPort);

  @override
  Future<void> execute(IncomeEntryAggregate aggregate) async {
    // Conversión de IncomeEntryAggregate a IncomeEntry
    final incomeEntry = IncomeEntry(
      id: aggregate.id,
      description: aggregate.description,
      amount: aggregate.amount,
      date: aggregate.date,
      category: aggregate.category,
      attachmentPath: aggregate.attachmentPath,
      currencySymbol: aggregate.currencySymbol,
    );

    // Validaciones o cualquier lógica de negocio necesaria antes de crear la entrada
    if (incomeEntry.description.isEmpty) {
      throw Exception('La descripción de la entrada de ingresos no puede estar vacía');
    }

    await incomeEntryPort.createEntry(incomeEntry);
  }
}
