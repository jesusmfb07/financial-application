// import '../../../../domain/aggregates/income_entry_aggregate.dart';
// import '../../../../domain/entities/income_entry_entity.dart';
// import '../../../ports/income_entry_port.dart';
// import '../../income_entry_use_case.dart';
//
// class GetIncomeEntriesQuery implements GetIncomeEntriesUseCase {
//   final IncomeEntryPort incomeEntryPort;
//
//   GetIncomeEntriesQuery(this.incomeEntryPort);
//
//   @override
//   Future<List<IncomeEntry>> execute(IncomeEntryAggregate aggregate) async {
//     return await incomeEntryPort.getEntries();
//   }
// }