import '../../../../domain/aggregates/currency_aggregate.dart';
import '../../../ports/currency_port.dart';
import '../../currency_use_case.dart';

class SetDefaultCurrencyCommand implements SetDefaultCurrencyUseCase {
  final CurrencyPort currencyPort;

  SetDefaultCurrencyCommand(this.currencyPort);

  @override
  Future<void> execute(CurrencyAggregate aggregate, String currencyCode) async {
    await currencyPort.setDefaultCurrency(currencyCode);
    aggregate.setDefaultCurrency(currencyCode);
  }
}