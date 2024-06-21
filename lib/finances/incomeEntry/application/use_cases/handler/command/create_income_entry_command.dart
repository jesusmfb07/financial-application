// import '../../../../domain/aggregates/income_entry_aggregate.dart';
// import '../../../../domain/entities/income_entry_entity.dart';
// import '../../../ports/income_entry_port.dart';
// import '../../income_entry_use_case.dart';
//
// class CreateIncomeEntryCommand implements CreateIncomeEntryUseCase {
//   final IncomeEntryPort incomeEntryPort;
//
//   CreateIncomeEntryCommand(this.incomeEntryPort);
//
//   @override
//   Future<void> execute(IncomeEntryAggregate aggregate, IncomeEntry entry) async {
//     aggregate.createEntry(entry);
//     await incomeEntryPort.createEntry(entry);
//   }
// }