import '../../domain/aggregates/income_aggregate.dart';

abstract class UpdateIncomeEntryUseCase {
  Future<void> execute(IncomeEntryAggregate aggregate);
}