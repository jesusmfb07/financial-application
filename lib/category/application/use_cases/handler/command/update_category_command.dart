import '../../../../domain/aggregates/category_aggregate.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../ports/category_port.dart';
import '../../category_use_case.dart';

class UpdateCategoryCommand implements UpdateCategoryUseCase {
  final CategoryPort categoryPort;

  UpdateCategoryCommand(this.categoryPort);

  @override
  Future<void> execute(CategoryAggregate aggregate, Category category) async {
    aggregate.updateCategory(category);
    await categoryPort.updateCategory(category);
  }
}
