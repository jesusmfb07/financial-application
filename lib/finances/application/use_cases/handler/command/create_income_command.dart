import '../../../../domain/aggregates/income_aggregate.dart';
import '../../../../domain/entities/income_entry_entity.dart';
import '../../../ports/income_port.dart';
import '../../income_use_case.dart';

class CreateIncomeEntryCommand implements CreateIncomeEntryUseCase {
  final IncomeEntryPort incomeEntryPort;

  CreateIncomeEntryCommand(this.incomeEntryPort);

  @override
  Future<void> execute(IncomeEntryAggregate aggregate, IncomeEntry entry) async {
    aggregate.createEntry(entry);
    await incomeEntryPort.createEntry(entry);
  }
}