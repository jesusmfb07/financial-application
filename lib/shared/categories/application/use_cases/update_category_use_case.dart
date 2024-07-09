import '../../domain/aggregates/category_aggregate.dart';

abstract class UpdateCategoryUseCase {
  Future<void> execute(CategoryAggregate categoryAggregate);
}