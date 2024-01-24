import 'dart:math';

import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/balance_model.dart';
import 'package:pasuhisab/app/data/model/ele_model.dart';
import 'package:pasuhisab/app/data/model/total_model.dart';

abstract class AllRepo {
  Future<int> electricity(int challid);
  Future<int> deleteAll(int challid);
  Future<int> totalof(String tablename, String columnname, int challid);
  Future<int> singleValue(String tablename, String columnname, int challid);
  Future<int> totaloftwoid(String tablename, String columnname, String column1,
      int challid, String id);
  Future<int> getMax(String tablename, String columnname, int challid);
  Future<TotalModel?> getTotalDana(String tablename, String column1,
      String column2, String column, int challid, String id);

  Future<TotalModel?> getTotalSingle(
      String tablename, String column1, String column2, int challid,
      {bool ch = false});
  Future<TotalModel?> getChickenSell(
      String tablename, String column1, String column2, int challid,
      {bool ch = false});

  Future<int> updateBalance(Balance balance);
  Future<Balance?> getBalance();
}

class AllRepositories implements AllRepo {
  @override
  Future<int> deleteAll(int challid) async {
    try {
      var dbClient = await con.db;
      int a = 0;

      for (var item in Dbname.deletetableList) {
        a = await dbClient.rawDelete(
            'DELETE FROM $item WHERE ${Dbname.ChallId} = ?', [challid]);
      }

      return a;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> totalof(String tablename, String columnname, int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.rawQuery(
          "SELECT SUM($columnname) FROM $tablename WHERE ${Dbname.ChallId}=$challid");
      int total = 0;
      if (columnname == Dbname.Kg) {
        double d = res[0]["SUM($columnname)"] as double;
        total = d.round();
      } else {
        total = res[0]["SUM($columnname)"] as int;
      }

      return res[0]["SUM($columnname)"] == null ? 0 : total;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> totaloftwoid(String tablename, String columnname, String column1,
      int challid, String id) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.rawQuery(
          "SELECT SUM($columnname) FROM $tablename WHERE ${Dbname.ChallId}=? and $column1 = ? ",
          [challid, id]);

      return res[0]["SUM($columnname)"] as int == null
          ? 0
          : res[0]["SUM($columnname)"] as int;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> singleValue(
      String tablename, String columnname, int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.rawQuery(
          "SELECT $columnname FROM $tablename WHERE ${Dbname.ChallId}=$challid");

      return res[0]["$columnname"] as int == null
          ? 0
          : res[0]["$columnname"] as int;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> getMax(String tablename, String columnname, int challid) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.rawQuery(
          "SELECT Max($columnname) FROM $tablename WHERE ${Dbname.ChallId}=$challid");

      return res[0]["Max($columnname)"] as int == null
          ? 0
          : res[0]["Max($columnname)"] as int;
    } catch (error) {
      return -1;
    }
  }

  Future<int> electricity(int challid) async {
    try {
      int total = 0;
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.Ele_TABLE,
          where: '${Dbname.ChallId} =?', whereArgs: [challid]);

      List<EleModel> list =
          res.isNotEmpty ? res.map((c) => EleModel.fromMap(c)).toList() : [];
      int ele = list[0]?.electricity ?? 0;
      int rent = list[0]?.rent ?? 0;
      int water = list[0]?.water ?? 0;
      total = ele + rent + water;

      return total;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<TotalModel?> getTotalDana(String tablename, String column1,
      String column2, String column, int challid, String id) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.rawQuery(
          "SELECT $column1,$column2 FROM $tablename WHERE ${Dbname.ChallId}=? and $column=?",
          [challid, id]);

      int total = 0;
      int qty = 0;
      List<int> rate = [];
      res.forEach((element) {
        qty = element['$column1'] as int ?? 0;
        rate.add(element['$column2'] as int ?? 0);
        total += qty * (element['$column2'] as int) ?? 0;
      });
      int ratevalue = 0;
      if (rate.length > 0) {
        var b0distinct = rate.toSet().toList();
        ratevalue = b0distinct.reduce(max);
      }
      TotalModel tm = new TotalModel(qty: qty, rate: ratevalue, total: total);
      return tm;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<TotalModel?> getTotalSingle(
      String tablename, String column1, String column2, int challid,
      {bool ch = false}) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.rawQuery(
          "SELECT $column1 ,$column2 FROM $tablename WHERE ${ch ? Dbname.Id : Dbname.ChallId}=?",
          [challid]);

      int qty = res[0][column1] as int ?? 0;
      int rate = res[0][column2] as int ?? 0;
      int total = qty * rate;

      TotalModel totalModel =
          new TotalModel(qty: qty, rate: rate, total: total);

      return totalModel;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<TotalModel?> getChickenSell(
      String tablename, String column1, String column2, int challid,
      {bool ch = false}) async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.rawQuery(
          "SELECT $column1,$column2 FROM $tablename WHERE ${Dbname.ChallId}=? ",
          [
            challid,
          ]);

      double total = 0;
      double kg = 0;
      double kgqty = 0;

      List<int> rate = [];
      res.forEach((element) {
        String qty = element['$column1'].toString() ?? 0.toString();
        rate.add(element['$column2'] as int ?? 0);
        kg = double.parse(qty);
        kgqty += kg;
        total += kg * (element['$column2'] as int) ?? 0;
      });
      int ratevalue = 0;
      if (rate.length > 0) {
        var b0distinct = rate.toSet().toList();
        ratevalue = b0distinct.reduce(max);
      }
      TotalModel tm = new TotalModel(
          qty: kgqty.round(), rate: ratevalue, total: total.round());

      return tm;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<int> updateBalance(Balance balance) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(Dbname.Balance_TABLE, balance.toMap(),
          where: 'id=?', whereArgs: [balance.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<Balance?> getBalance() async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.Balance_TABLE);

      List<Balance> list =
          res.isNotEmpty ? res.map((c) => Balance.fromMap(c)).toList() : [];
      if (list != null)
        return list[0];
      else
        return null;
    } catch (error) {
      return null;
    }
  }
}
