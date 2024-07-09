import '../../../../domain/aggregates/category_aggregate.dart';

import '../../../ports/category_port.dart';
import '../../delete_category_use_case.dart';


  class DeleteCategoryCommand implements DeleteCategoryUseCase {
    final CategoryPort categoryPort;

    DeleteCategoryCommand(this.categoryPort);

    @override
    Future<void> execute(CategoryAggregate aggregate) async {
      // Aquí puedes realizar validaciones si es necesario
      await categoryPort.deleteCategory(aggregate.id);
    }
  }