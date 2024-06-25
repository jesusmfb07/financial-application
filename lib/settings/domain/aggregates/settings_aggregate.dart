import '../entities/settings_entity.dart';

class SettingsAggregate {
  Settings? settings;

  SettingsAggregate({this.settings});

  void createSettings(Settings newSettings) {
    settings = newSettings;
  }

  void updateSettings(Settings updatedSettings) {
    if (settings != null && settings!.username == updatedSettings.username) {
      settings = updatedSettings;
    } else {
      throw Exception('Settings not found or username mismatch');
    }
  }

  void deleteSettings() {
    settings = null;
  }
}