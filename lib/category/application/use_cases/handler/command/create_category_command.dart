import '../../../../domain/aggregates/category_aggregate.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../ports/category_port.dart';
import '../../category_use_case.dart';

class CreateCategoryCommand implements CreateCategoryUseCase {
  final CategoryPort categoryPort;

  CreateCategoryCommand(this.categoryPort);

  @override
  Future<void> execute(CategoryAggregate aggregate,Category category) async {
    await categoryPort.createCategory(category);
  }
}