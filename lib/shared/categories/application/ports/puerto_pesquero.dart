abstract class BackupPort {
  Future<void> exportBackup();
  Future<void> importBackup(String backupData);
}