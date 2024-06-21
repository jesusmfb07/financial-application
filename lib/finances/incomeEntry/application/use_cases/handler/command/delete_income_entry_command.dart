// import '../../../../domain/aggregates/income_entry_aggregate.dart';
// import '../../../../domain/entities/income_entry_entity.dart';
// import '../../../ports/income_entry_port.dart';
// import '../../income_entry_use_case.dart';
//
// class DeleteIncomeEntryCommand implements DeleteIncomeEntryUseCase {
//   final IncomeEntryPort incomeEntryPort;
//
//   DeleteIncomeEntryCommand(this.incomeEntryPort);
//
//   @override
//   Future<void> execute(IncomeEntryAggregate aggregate, IncomeEntry entry) async {
//     aggregate.deleteEntry(entry);
//     await incomeEntryPort.deleteEntry(entry.id);
//   }
// }