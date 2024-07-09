import '../../../../domain/aggregates/category_aggregate.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../ports/category_port.dart';
import '../../get_category_use_case.dart';

class GetCategoriesQuery implements GetCategoriesUseCase {
  final CategoryPort categoryPort;

  GetCategoriesQuery(this.categoryPort);

  @override
  Future<List<CategoryAggregate>> execute() async {
    final categories = await categoryPort.getCategories();
    // Convertir la lista de Category a CategoryAggregate
    return categories.map((category) => Category(
        id: category.id,
        name: category.name
    )).toList();
  }
}