// import '../../../../domain/aggregates/finance_entry.aggregate.dart';
// import '../../finances_entries_usecase.dart';
//
// class DeleteFinanceEntryCommand implements DeleteFinanceEntryUseCase {
//   @override
//   Future<void> execute(FinanceEntryAggregate aggregate, String description) async {
//     final entry = aggregate.entries.firstWhere((e) => e.description == description);
//     aggregate.deleteEntry(entry);
//   }
// }