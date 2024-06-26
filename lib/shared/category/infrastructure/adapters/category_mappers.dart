import '../../domain/entities/category_entity.dart';

class CategoryMapper {
  static Map<String, dynamic> toMap(Category category) {
    return {
      'id': category.id,
      'name': category.name,
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
    );
  }
}