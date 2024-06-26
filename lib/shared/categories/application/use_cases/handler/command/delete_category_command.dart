import '../../../../domain/aggregates/category_aggregate.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../ports/category_port.dart';
import '../../category_use_case.dart';

class DeleteCategoryCommand implements DeleteCategoryUseCase {
  final CategoryPort categoryPort;

  DeleteCategoryCommand(this.categoryPort);

  @override
  Future<void> execute(CategoryAggregate aggregate, Category category) async {
    aggregate.deleteCategory(category);
    await categoryPort.deleteCategory(category.id);
  }
}