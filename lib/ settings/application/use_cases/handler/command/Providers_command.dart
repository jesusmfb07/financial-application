import '../../../ports/settings_port.dart';
import '../../../settings_use_case.dart';

class NavigateToProvidersCommand implements NavigateToProvidersPageUseCase {
  final SettingsPort settingsPort;

  NavigateToProvidersCommand(this.settingsPort);

  @override
  Future<void> execute() async {
    await settingsPort.navigateToProvidersPage();
  }
}