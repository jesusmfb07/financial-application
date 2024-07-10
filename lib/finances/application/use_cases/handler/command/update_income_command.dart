import '../../../../domain/aggregates/income_aggregate.dart';
import '../../../../domain/entities/income_entry_entity.dart';
import '../../../ports/income_port.dart';
import '../../update_income_use_case.dart';

class UpdateIncomeEntryCommand implements UpdateIncomeEntryUseCase {
  final IncomeEntryPort incomeEntryPort;

  UpdateIncomeEntryCommand(this.incomeEntryPort);

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

    // Aquí puedes realizar validaciones si es necesario
    await incomeEntryPort.updateEntry(incomeEntry);
  }
}