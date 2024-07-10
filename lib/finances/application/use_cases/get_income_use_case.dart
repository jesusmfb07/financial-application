import '../../domain/aggregates/income_aggregate.dart';
import '../../domain/entities/income_entry_entity.dart';

abstract class GetIncomeEntriesUseCase {
  Future<List<IncomeEntryAggregate>> execute();
}