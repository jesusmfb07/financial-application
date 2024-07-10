import '../../../../domain/entities/currency_entity.dart';
import '../../../ports/currency_port.dart';
import '../../get_currencies_use_case.dart';

class GetCurrenciesQuery implements GetCurrenciesUseCase {
  final CurrencyPort currencyPort;

  GetCurrenciesQuery(this.currencyPort);

  @override
  Future<List<Currency>> execute() async {
    return await currencyPort.getCurrencies();
  }
}