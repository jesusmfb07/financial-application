abstract class EgressEntryAggregate {
  int? get id;
  String get description;
  double get amount;
  DateTime get date;
  String? get category;
  String? get provider;
  String? get attachmentPath;
  String get currencySymbol;
}