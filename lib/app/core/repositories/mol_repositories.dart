import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/mol_model.dart';

abstract class MolRepo {
  Future<List<MolModel>> getAllMolModel(int challid);
  Future<int> saveMolModel(MolModel molModel);
  Future<int> updateMolModel(MolModel molModel);
  Future<int> deleteMolModel(int id);
}

class MolRepositories implements MolRepo {
  @override
  Future<int> deleteMolModel(int id) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient
          .rawDelete('DELETE FROM ${Dbname.Mol_TABLE} WHERE id = ?', [id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<List<MolModel>> getAllMolModel(int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.Mol_TABLE,
          where: '${Dbname.ChallId} =?', whereArgs: [challid]);

      List<MolModel> list =
          res.isNotEmpty ? res.map((c) => MolModel.fromMap(c)).toList() : [];

      return list;
    } catch (error) {
      return [];
    }
  }

  @override
  Future<int> saveMolModel(MolModel molModel) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.insert(Dbname.Mol_TABLE, molModel.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateMolModel(MolModel molModel) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(Dbname.Mol_TABLE, molModel.toMap(),
          where: "id = ?", whereArgs: [molModel.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
