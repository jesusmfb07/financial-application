import '../../../../domain/aggregates/category_aggregate.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../ports/category_port.dart';
import '../../create_category_use_case.dart';


  class CreateCategoryCommand implements CreateCategoryUseCase {
    final CategoryPort categoryPort;

    CreateCategoryCommand(this.categoryPort);

    @override
    Future<void> execute(CategoryAggregate categoryAggregate) async {
      // Conversión de CategoryAggregate a Category
      final category = Category(id: categoryAggregate.id, name: categoryAggregate.name);

      // Validaciones o cualquier lógica de negocio necesaria antes de crear la categoría
      if (category.name.isEmpty) {
        throw Exception('El nombre de la categoría no puede estar vacío');
      }

      await categoryPort.createCategory(category);
    }
  }