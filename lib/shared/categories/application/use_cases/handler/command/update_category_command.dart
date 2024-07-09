import '../../../../domain/aggregates/category_aggregate.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../ports/category_port.dart';
import '../../update_category_use_case.dart';

class UpdateCategoryCommand implements UpdateCategoryUseCase {
  final CategoryPort categoryPort;

  UpdateCategoryCommand(this.categoryPort);

  @override
  Future<void> execute(CategoryAggregate aggregate) async {
    // Conversión de CategoryAggregate a Category
    final category = Category(id: aggregate.id, name: aggregate.name);

    // Aquí puedes realizar validaciones si es necesario
    await categoryPort.updateCategory(category);
  }
}

