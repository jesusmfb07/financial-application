import '../../../../domain/aggregates/currency_aggregate.dart';
import '../../../../domain/entities/currency_entity.dart';
import '../../../ports/currency_port.dart';
import '../../currency_use_case.dart';

class GetCurrenciesQuery implements GetCurrenciesUseCase {
  final CurrencyPort currencyPort;

  GetCurrenciesQuery(this.currencyPort);

  @override
  Future<List<Currency>> execute(CurrencyAggregate aggregate) async {
    return await currencyPort.getCurrencies();
  }
}