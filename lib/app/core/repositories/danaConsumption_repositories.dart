import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/dana_consumption.dart';

abstract class DanaConsumeRepo {
  Future<List<DanaConsumption>> getAlldanaConsumption(int challid);
  Future<int> savedanaConsumption(DanaConsumption danaConsumption);
  Future<int> updatedanaConsumption(DanaConsumption danaConsumption);
  Future<int> deleteConsumption(int id);
  Future<int> deletedanaConsumption(int danaid);
  Future<int> countdanaConsumption(int id);
}

class DanaConsumeRepositories implements DanaConsumeRepo {
  @override
  Future<int> deleteConsumption(int id) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.rawDelete(
          'DELETE FROM ${Dbname.DANACONSUMPTION_TABLE} WHERE id = ?', [id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<List<DanaConsumption>> getAlldanaConsumption(int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.DANACONSUMPTION_TABLE,
          where: '${Dbname.ChallId}=?', whereArgs: [challid]);

      List<DanaConsumption> list = res.isNotEmpty
          ? res.map((c) => DanaConsumption.fromMap(c)).toList()
          : [];
      return list;
    } catch (error) {
      return [];
    }
  }

  @override
  Future<int> savedanaConsumption(DanaConsumption danaConsumption) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.insert(
          Dbname.DANACONSUMPTION_TABLE, danaConsumption.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updatedanaConsumption(DanaConsumption danaConsumption) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(
          Dbname.DANACONSUMPTION_TABLE, danaConsumption.toMap(),
          where: "id = ?", whereArgs: [danaConsumption.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> countdanaConsumption(int id) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.rawQuery(
          "SELECT SUM(${Dbname.Qty}) FROM ${Dbname.DANACONSUMPTION_TABLE} WHERE ${Dbname.Dana}=$id");

      return res[0]["SUM(${Dbname.Qty})"] as int;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> deletedanaConsumption(int danaid) async {
    try {
      var dbClient = await con.db;
      final res = await dbClient.rawDelete(
          'DELETE FROM  ${Dbname.DANACONSUMPTION_TABLE} WHERE ${Dbname.Dana} =$danaid');

      if (res != null)
        return 1;
      else
        return -1;
    } catch (error) {
      return -1;
    }
  }
}
