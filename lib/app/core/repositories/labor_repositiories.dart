import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/labor.dart';

abstract class LaborRepo {
  Future<Labor?> getAllLabor(int challid);
  Future<int> saveLabor(Labor labor);
  Future<int> updateLabor(Labor labor);
  Future<int> deleteLabor(int id);
}

class LaborRepositories implements LaborRepo {
  @override
  Future<int> deleteLabor(int id) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.rawDelete(
          'DELETE FROM ${Dbname.LABOR_TABLE} WHERE ${Dbname.ChallId} = ?',
          [id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<Labor?> getAllLabor(int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.LABOR_TABLE,
          where: '${Dbname.ChallId} =?', whereArgs: [challid]);

      List<Labor> list =
          res.isNotEmpty ? res.map((c) => Labor.fromMap(c)).toList() : [];
      if (list != null)
        return list[0];
      else
        return null;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<int> saveLabor(Labor labor) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.insert(Dbname.LABOR_TABLE, labor.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateLabor(Labor labor) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(Dbname.LABOR_TABLE, labor.toMap(),
          where: "id = ?", whereArgs: [labor.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
