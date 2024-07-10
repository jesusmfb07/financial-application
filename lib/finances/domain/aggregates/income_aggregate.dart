abstract class IncomeEntryAggregate {
  int? get id;
  String get description;
  double get amount;
  DateTime get date;
  String? get category;
  String? get attachmentPath;
  String get currencySymbol;
}