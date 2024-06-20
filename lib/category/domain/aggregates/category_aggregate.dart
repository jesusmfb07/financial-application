import '../entities/category_entity.dart';

class CategoryAggregate {
  final List<Category> categories;

  CategoryAggregate({required this.categories});

  void createCategory(Category category) {
    categories.add(category);
  }

  void updateCategory(Category category) {
    final index = categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      categories[index] = category;
    }
  }

  void deleteCategory(Category category) {
    categories.removeWhere((c) => c.id == category.id);
  }
}