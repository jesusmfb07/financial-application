import '../../domain/aggregates/category_aggregate.dart';

abstract class CreateCategoryUseCase {
  Future<void> execute(CategoryAggregate categoryAggregate);
}