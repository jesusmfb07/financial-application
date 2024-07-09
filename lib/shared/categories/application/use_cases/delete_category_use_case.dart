import '../../domain/aggregates/category_aggregate.dart';

abstract class DeleteCategoryUseCase {
  Future<void> execute(CategoryAggregate categoryAggregate);
}