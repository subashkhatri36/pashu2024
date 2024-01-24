import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/model/balance_model.dart';
import 'package:pasuhisab/app/data/model/settings.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

DatabaseHelper con = new DatabaseHelper();

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  late Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "data_hisab.db");

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', 'hisab.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }

    var ourDb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      for (var table in Dbname.tableNameList) {
        await db.execute(table);
      }
      Settings setting = new Settings(
          autobackup: true,
          datetypeNepali: false,
          languageNepali: false,
          themelight: true);
      Balance b = new Balance(total: 0, remarks: '', enterdate: DateTime.now());
      db.insert(Dbname.Balance_TABLE, b.toMap());
      db.insert(Dbname.SETTING_TABLE, setting.toMap());
    });
    return ourDb;
  }
}
