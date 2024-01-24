import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/chall_dead.dart';

abstract class DeadChallaRepo {
  Future<List<ChallDead>> getChallaDead(int challid);
  Future<int> saveChallDead(ChallDead challDead);
  Future<int> updateChallaDead(ChallDead challDead);
  Future<int> deleteChallaDead(int id);
}

class DeadChallaRepositories implements DeadChallaRepo {
  @override
  Future<int> deleteChallaDead(int id) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.rawDelete(
          'DELETE FROM ${Dbname.ChallDEAD_TABLE} WHERE id = ?', [id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<List<ChallDead>> getChallaDead(int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.ChallDEAD_TABLE,
          where: '${Dbname.ChallId}=?', whereArgs: [challid]);

      List<ChallDead> list =
          res.isNotEmpty ? res.map((c) => ChallDead.fromMap(c)).toList() : [];
      return list;
    } catch (error) {
      return [];
    }
  }

  @override
  Future<int> saveChallDead(ChallDead challDead) async {
    try {
      var dbClient = await con.db;
      int res =
          await dbClient.insert(Dbname.ChallDEAD_TABLE, challDead.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateChallaDead(ChallDead challDead) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(Dbname.ChallDEAD_TABLE, challDead.toMap(),
          where: "id = ?", whereArgs: [challDead.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
