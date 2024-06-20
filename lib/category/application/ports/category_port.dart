import '../../domain/entities/category_entity.dart';


abstract class CategoryPort {
  Future<List<Category>> getCategories();
  Future<void> createCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String id);
}