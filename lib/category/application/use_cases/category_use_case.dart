import '../../domain/aggregates/category_aggregate.dart';
import '../../domain/entities/category_entity.dart';

abstract class getCategoriesUseCase {
  Future<List<Category>> execute(CategoryAggregate aggregate);
}

abstract class CreateCategoryUseCase {
  Future<void> execute(CategoryAggregate aggregate,Category contact);
}

abstract class UpdateCategoryUseCase {
  Future<void> execute(CategoryAggregate aggregate, Category contact);
}

abstract class DeleteCategoryUseCase {
  Future<void> execute(CategoryAggregate aggregate, Category contact);
}