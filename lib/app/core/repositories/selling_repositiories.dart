import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/chall_selling_record.dart';

abstract class SellingRepo {
  Future<List<Selling>> getAllSelling(int challid);
  Future<int> saveSelling(Selling selling);
  Future<int> updateSelling(Selling selling);
  Future<int> deleteSelling(int id);
}

class SellingRepositories implements SellingRepo {
  @override
  Future<int> deleteSelling(int id) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.rawDelete(
          'DELETE FROM ${Dbname.ChickenSelling_TABLE} WHERE id = ?', [id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<List<Selling>> getAllSelling(int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.ChickenSelling_TABLE,
          where: '${Dbname.ChallId}=?', whereArgs: [challid]);

      List<Selling> list =
          res.isNotEmpty ? res.map((c) => Selling.fromMap(c)).toList() : [];

      return list;
    } catch (error) {
      return [];
    }
  }

  @override
  Future<int> saveSelling(Selling selling) async {
    try {
      var dbClient = await con.db;
      int res =
          await dbClient.insert(Dbname.ChickenSelling_TABLE, selling.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateSelling(Selling selling) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(
          Dbname.ChickenSelling_TABLE, selling.toMap(),
          where: "id = ?", whereArgs: [selling.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
