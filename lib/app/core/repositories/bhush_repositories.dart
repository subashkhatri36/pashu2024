import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/bhush_model.dart';

abstract class BhushRepo {
  Future<Bhush?> getAllBhush(int challid);

  Future<int> saveBhush(Bhush bhush);
  Future<int> updateBhush(Bhush bhush);
  Future<int> deleteBhush(int id);
}

class BhushRepositories implements BhushRepo {
  @override
  Future<int> deleteBhush(int id) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.rawDelete(
          'DELETE FROM ${Dbname.Bhush_TABLE} WHERE ${Dbname.ChallId} = ?',
          [id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<Bhush?> getAllBhush(int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.Bhush_TABLE);

      List<Bhush> list =
          res.isNotEmpty ? res.map((c) => Bhush.fromMap(c)).toList() : [];
      if (list != null)
        return list[0];
      else
        return null;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<int> saveBhush(Bhush bhush) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.insert(Dbname.Bhush_TABLE, bhush.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateBhush(Bhush bhush) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(Dbname.Bhush_TABLE, bhush.toMap(),
          where: "id = ?", whereArgs: [bhush.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
