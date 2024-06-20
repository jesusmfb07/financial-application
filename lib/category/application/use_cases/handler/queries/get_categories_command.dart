import '../../../../domain/aggregates/category_aggregate.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../ports/category_port.dart';
import '../../category_use_case.dart';

class GetCategoriesQuery implements GetCategoriesUseCase {
  final CategoryPort categoryPort;

  GetCategoriesQuery(this.categoryPort);

  @override
  Future<List<Category>> execute(CategoryAggregate aggregate) async {
    return await categoryPort.getCategories();
  }
}