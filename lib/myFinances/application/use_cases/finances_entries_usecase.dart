import '../../domain/aggregates/finance_entry.aggregate.dart';
import '../../domain/entities/finance_entry.entity.dart';

abstract class GetFinanceEntriesUseCase {
  Future<List<FinanceEntry>> execute(FinanceEntryAggregate aggregate);
}

abstract class CreateFinanceEntryUseCase {
  Future<void> execute(FinanceEntryAggregate aggregate, FinanceEntry entry);
}


abstract class UpdateFinanceEntryUseCase {
  Future<void> execute(FinanceEntryAggregate aggregate, FinanceEntry entry);
}
