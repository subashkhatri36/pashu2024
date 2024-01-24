import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/challa_record.dart';

abstract class ChallRecordRepo {
  Future<List<ChallaRecord>> getChallRecord();
  Future<ChallaRecord?> getSingleChallRecord(int id);
  Future<int> saveChallRecord(ChallaRecord challaRecord);
  Future<int> updateChallRecord(ChallaRecord challaRecord);
  Future<int> deleteChallRecord(
      int challid); //it will delete all the respective data too
}

class ChallRepositories implements ChallRecordRepo {
  @override
  Future<int> deleteChallRecord(int challid) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.rawDelete(
          'DELETE FROM ${Dbname.CHALLRECORD_TABLE} WHERE id = ?', [challid]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<List<ChallaRecord>> getChallRecord() async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.CHALLRECORD_TABLE);

      List<ChallaRecord> list = res.isNotEmpty
          ? res.map((c) => ChallaRecord.fromMap(c)).toList()
          : [];
      return list;
    } catch (error) {
      return [];
    }
  }

  @override
  Future<int> saveChallRecord(ChallaRecord challaRecord) async {
    try {
      var dbClient = await con.db;
      int res =
          await dbClient.insert(Dbname.CHALLRECORD_TABLE, challaRecord.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateChallRecord(ChallaRecord challaRecord) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(
          Dbname.CHALLRECORD_TABLE, challaRecord.toMap(),
          where: "id = ?", whereArgs: [challaRecord.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<ChallaRecord?> getSingleChallRecord(int id) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient
          .query(Dbname.CHALLRECORD_TABLE, where: 'id =?', whereArgs: [id]);

      var list = res.isNotEmpty
          ? res.map((c) => ChallaRecord.fromMap(c)).toList()
          : null;
      if (list != null)
        return list[0];
      else
        return null;
    } catch (error) {
      return null;
    }
  }
}
