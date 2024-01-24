import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/ele_model.dart';

abstract class ElectricityRepo {
  Future<EleModel?> getAllEleModel(int challid);
  Future<int> saveEleModel(EleModel eleModel);
  Future<int> updateEleModel(EleModel eleModel);
  Future<int> deleteEleModel(int id);
}

class ElectricityRepositories implements ElectricityRepo {
  @override
  Future<int> deleteEleModel(int id) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.rawDelete(
          'DELETE FROM ${Dbname.Ele_TABLE} WHERE ${Dbname.ChallId} = ?', [id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<EleModel?> getAllEleModel(int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.Ele_TABLE,
          where: "${Dbname.ChallId} =?", whereArgs: [challid]);

      List<EleModel> list =
          res.isNotEmpty ? res.map((c) => EleModel.fromMap(c)).toList() : [];
      if (list != null)
        return list[0];
      else
        return null;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<int> saveEleModel(EleModel eleModel) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.insert(Dbname.Ele_TABLE, eleModel.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateEleModel(EleModel eleModel) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(Dbname.Ele_TABLE, eleModel.toMap(),
          where: "id = ?", whereArgs: [eleModel.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
