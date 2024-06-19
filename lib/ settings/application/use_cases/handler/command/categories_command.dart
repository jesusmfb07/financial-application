import '../../../ports/settings_port.dart';
import '../../../settings_use_case.dart';

class NavigateToCategoriesCommand implements NavigateToCategoriesPageUseCase {
  final SettingsPort settingsPort;

  NavigateToCategoriesCommand(this.settingsPort);

  @override
  Future<void> execute() async {
    await settingsPort.navigateToCategoriesPage();
  }
}