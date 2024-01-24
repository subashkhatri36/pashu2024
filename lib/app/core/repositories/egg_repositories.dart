import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/egg_model.dart';

abstract class EggRepo {
  Future<List<EggModel>> getAllEggModel(int challid);
  Future<int> saveEggModel(EggModel eleModel);
  Future<int> updateEggModel(EggModel eleModel);
  Future<int> deleteEggModel(int id);
}

class EggRepositories implements EggRepo {
  @override
  Future<int> deleteEggModel(int id) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient
          .rawDelete('DELETE FROM ${Dbname.Egg_TABLE} WHERE id = ?', [id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<List<EggModel>> getAllEggModel(int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.Egg_TABLE);

      List<EggModel> list =
          res.isNotEmpty ? res.map((c) => EggModel.fromMap(c)).toList() : [];

      return list;
    } catch (error) {
      return [];
    }
  }

  @override
  Future<int> saveEggModel(EggModel eleModel) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.insert(Dbname.Egg_TABLE, eleModel.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateEggModel(EggModel eleModel) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(Dbname.Egg_TABLE, eleModel.toMap(),
          where: "id = ?", whereArgs: [eleModel.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
