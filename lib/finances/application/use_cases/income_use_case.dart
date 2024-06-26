import '../../domain/aggregates/income_aggregate.dart';
import '../../domain/entities/income_entry_entity.dart';

abstract class GetIncomeEntriesUseCase {
  Future<List<IncomeEntry>> execute(IncomeEntryAggregate aggregate);
}

abstract class CreateIncomeEntryUseCase {
  Future<void> execute(IncomeEntryAggregate aggregate, IncomeEntry entry);
}

abstract class UpdateIncomeEntryUseCase {
  Future<void> execute(IncomeEntryAggregate aggregate, IncomeEntry entry);
}