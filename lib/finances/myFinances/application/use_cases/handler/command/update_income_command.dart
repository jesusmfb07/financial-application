import '../../../../domain/aggregates/income_aggregate.dart';
import '../../../../domain/entities/income_entry_entity.dart';
import '../../../ports/income_port.dart';
import '../../income_use_case.dart';

class UpdateIncomeEntryCommand implements UpdateIncomeEntryUseCase {
  final IncomeEntryPort incomeEntryPort;

  UpdateIncomeEntryCommand(this.incomeEntryPort);

  @override
  Future<void> execute(IncomeEntryAggregate aggregate, IncomeEntry entry) async {
    aggregate.updateEntry(entry);
    await incomeEntryPort.updateEntry(entry);
  }
}