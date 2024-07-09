import '../../domain/aggregates/category_aggregate.dart';


abstract class GetCategoriesUseCase {
  Future<List<CategoryAggregate>> execute();
}

