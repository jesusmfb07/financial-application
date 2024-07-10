import '../../../../domain/aggregates/income_aggregate.dart';
import '../../../../domain/entities/income_entry_entity.dart';
import '../../../ports/income_port.dart';
import '../../get_income_use_case.dart';

class GetIncomeEntriesQuery implements GetIncomeEntriesUseCase {
  final IncomeEntryPort incomeEntryPort;

  GetIncomeEntriesQuery(this.incomeEntryPort);

  @override
  Future<List<IncomeEntryAggregate>> execute() async {
    final entries = await incomeEntryPort.getEntries();
    // Convertir la lista de IncomeEntry a IncomeEntryAggregate
    return entries.map((entry) => IncomeEntry(
      id: entry.id,
      description: entry.description,
      amount: entry.amount,
      date: entry.date,
      category: entry.category,
      attachmentPath: entry.attachmentPath,
      currencySymbol: entry.currencySymbol,
    )).toList();
  }
}