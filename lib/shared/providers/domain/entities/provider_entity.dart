import '../aggregates/provider_aggregate.dart';

class Provider implements ProviderAggregate {
  @override
  final String id;

  @override
  final String name;

  @override
  final String? phoneNumber;

  @override
  final String? ruc;

  Provider({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.ruc,
  });
}