import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/other.dart';

abstract class OtherRepo {
  Future<List<OtherModel>> getAllOtherModel(int challid, bool inout);
  Future<int> saveOtherModel(OtherModel otherModel);
  Future<int> updateOtherModel(OtherModel otherModel);
  Future<int> deleteOtherModel(int id);
}

class OtherRepositories implements OtherRepo {
  @override
  Future<int> deleteOtherModel(int id) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient
          .rawDelete('DELETE FROM ${Dbname.Other_TABLE} WHERE id = ?', [id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<List<OtherModel>> getAllOtherModel(int challid, bool inout) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.Other_TABLE,
          where: '${Dbname.Inout} =? and ${Dbname.ChallId}=?',
          whereArgs: [inout == true ? 1 : 0, challid]);

      List<OtherModel> list =
          res.isNotEmpty ? res.map((c) => OtherModel.fromMap(c)).toList() : [];
      if (list != null) return list;
      return [];
    } catch (error) {
      return [];
    }
  }

  @override
  Future<int> saveOtherModel(OtherModel otherModel) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.insert(Dbname.Other_TABLE, otherModel.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateOtherModel(OtherModel otherModel) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(Dbname.Other_TABLE, otherModel.toMap(),
          where: "id = ?", whereArgs: [otherModel.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
