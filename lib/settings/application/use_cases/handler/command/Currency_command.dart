import '../../../ports/settings_port.dart';
import '../../../settings_use_case.dart';

class NavigateToCurrencyCommand implements NavigateToCurrencyPageUseCase {
  final SettingsPort settingsPort;

  NavigateToCurrencyCommand(this.settingsPort);

  @override
  Future<void> execute() async {
    await settingsPort.navigateToCurrencyPage();
  }
}