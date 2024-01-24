import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/medicine.dart';

abstract class MedicineRepo {
  Future<List<Medicine>> getAllMedicine(int challid);
  Future<int> saveMedicine(Medicine medicine);
  Future<int> updateMedicine(Medicine medicine);
  Future<int> deleteMedicine(int id);
}

class MedicineRepositories implements MedicineRepo {
  @override
  Future<int> deleteMedicine(int id) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient
          .rawDelete('DELETE FROM ${Dbname.MEDICINE_TABLE} WHERE id = ?', [id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<List<Medicine>> getAllMedicine(int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.MEDICINE_TABLE,
          where: '${Dbname.ChallId} =?', whereArgs: [challid]);

      List<Medicine> list =
          res.isNotEmpty ? res.map((c) => Medicine.fromMap(c)).toList() : [];

      return list;
    } catch (error) {
      return [];
    }
  }

  @override
  Future<int> saveMedicine(Medicine medicine) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.insert(Dbname.MEDICINE_TABLE, medicine.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateMedicine(Medicine medicine) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(Dbname.MEDICINE_TABLE, medicine.toMap(),
          where: "id = ?", whereArgs: [medicine.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
