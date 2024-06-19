import '../../../ports/settings_port.dart';
import '../../../settings_use_case.dart';

class NavigateToRemindersCommand implements NavigateToRemindersPageUseCase {
  final SettingsPort settingsPort;

  NavigateToRemindersCommand(this.settingsPort);

  @override
  Future<void> execute() async {
    await settingsPort.navigateToRemindersPage();
  }
}