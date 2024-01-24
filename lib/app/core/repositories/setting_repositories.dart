import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/settings.dart';

abstract class SettingsRepo {
  Future<Settings> getSettings();
  Future<int> updateSettings(Settings settings);
}

class SettingsRepositories implements SettingsRepo {
  @override
  Future<Settings> getSettings() async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.SETTING_TABLE);

      List<Settings> list =
          res.isNotEmpty ? res.map((c) => Settings.fromMap(c)).toList() : [];
      return list[0];
    } catch (error) {
      return Settings();
    }
  }

  @override
  Future<int> updateSettings(Settings settings) async {
    try {
      var dbClient = await con.db;

      int res = await dbClient.update(Dbname.SETTING_TABLE, settings.toMap(),
          where: "id = ?", whereArgs: [settings.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
