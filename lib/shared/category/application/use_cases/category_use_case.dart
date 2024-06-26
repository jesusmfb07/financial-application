import '../../domain/aggregates/category_aggregate.dart';
import '../../domain/entities/category_entity.dart';

abstract class GetCategoriesUseCase {
  Future<List<Category>> execute(CategoryAggregate aggregate);
}

abstract class CreateCategoryUseCase {
  Future<void> execute(CategoryAggregate aggregate, Category category);
}

abstract class UpdateCategoryUseCase {
  Future<void> execute(CategoryAggregate aggregate, Category category);
}

abstract class DeleteCategoryUseCase {
  Future<void> execute(CategoryAggregate aggregate, Category category);
}
