class Provider {
  final String id;
  final String name;
  final int? phoneNumber;
  final int? ruc;

  Provider({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.ruc,
  });
}