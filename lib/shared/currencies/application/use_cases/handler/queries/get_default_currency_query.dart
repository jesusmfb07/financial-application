import '../../../../domain/aggregates/currency_aggregate.dart';
import '../../../../domain/entities/currency_entity.dart';
import '../../../ports/currency_port.dart';
import '../../currency_use_case.dart';

class GetDefaultCurrencyQuery implements GetDefaultCurrencyUseCase {
  final CurrencyPort currencyPort;

  GetDefaultCurrencyQuery(this.currencyPort);

  @override
  Future<Currency?> execute(CurrencyAggregate aggregate) async {
    final defaultCurrency = await currencyPort.getDefaultCurrency();
    if (defaultCurrency != null) {
      aggregate.setDefaultCurrency(defaultCurrency.code);
    }
    return defaultCurrency;
  }
}