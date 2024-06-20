import '../../application/ports/category_port.dart';
import '../../domain/entities/category_entity.dart';

class CategoryAdapter implements CategoryPort {
  List<Category> _categories = [];

  @override
  Future<List<Category>> getCategories() async {
    return _categories;
  }

  @override
  Future<void> createCategory(Category category) async {
    _categories.add(category);
  }

  @override
  Future<void> updateCategory(Category category) async {
    final index = _categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      _categories[index] = category;
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    _categories.removeWhere((c) => c.id == id);
  }
}