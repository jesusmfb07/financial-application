import '../../../../domain/entities/currency_entity.dart';
import '../../../ports/currency_port.dart';
import '../../get_default_currency_use_case.dart';

class GetDefaultCurrencyQuery implements GetDefaultCurrencyUseCase {
  final CurrencyPort currencyPort;

  GetDefaultCurrencyQuery(this.currencyPort);

  @override
  Future<Currency?> execute() async {
    return await currencyPort.getDefaultCurrency();
  }
}