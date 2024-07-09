import '../aggregates/category_aggregate.dart';

class Category implements CategoryAggregate {
  @override
  final String id;

  @override
  final String name;

  Category({required this.id, required this.name});
}