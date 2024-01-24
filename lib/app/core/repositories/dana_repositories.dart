import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/dana_record.dart';

abstract class DanaRepo {
  Future<List<Dana>> getAllDana(int challid);
  Future<int> saveDana(Dana dana);
  Future<int> updateDana(Dana dana);
  Future<int> deleteDana(int id);
  Future<int> deleteGroupDana(int challid);
}

class DanaRepositiories implements DanaRepo {
  @override
  Future<int> deleteDana(int id) async {
    try {
      var dbClient = await con.db;
      int a = 0;

      a = await dbClient.rawDelete(
          'DELETE FROM ${Dbname.DANACONSUMPTION_TABLE} WHERE ${Dbname.Dana} = ?',
          [id]);
      if (a > 0) {
        a = await dbClient
            .rawDelete('DELETE FROM ${Dbname.DANA_TABLE} WHERE id = ?', [id]);
      } else {
        a = await dbClient
            .rawDelete('DELETE FROM ${Dbname.DANA_TABLE} WHERE id = ?', [id]);
      }

      return a;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> deleteGroupDana(int challid) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.rawDelete(
          'DELETE FROM ${Dbname.DANA_TABLE} WHERE ${Dbname.ChallId} = ?',
          [challid]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<List<Dana>> getAllDana(int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.DANA_TABLE,
          where: '${Dbname.ChallId}=?', whereArgs: [challid]);

      List<Dana> list =
          res.isNotEmpty ? res.map((c) => Dana.fromMap(c)).toList() : [];

      return list;
    } catch (error) {
      return [];
    }
  }

  @override
  Future<int> saveDana(Dana dana) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.insert(Dbname.DANA_TABLE, dana.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateDana(Dana dana) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(Dbname.DANA_TABLE, dana.toMap(),
          where: "id = ?", whereArgs: [dana.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
