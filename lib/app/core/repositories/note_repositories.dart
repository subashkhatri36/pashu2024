import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/data/database/database.dart';
import 'package:pasuhisab/app/data/model/note_model.dart';

abstract class NoteRepo {
  Future<List<Notes>> getAllNotes();
  Future<int> saveNotes(Notes notes);
  Future<int> updateNotes(Notes notes);
  Future<int> deleteNotes(int id);
}

class NoteRepositories implements NoteRepo {
  @override
  Future<int> deleteNotes(int id) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient
          .rawDelete('DELETE FROM ${Dbname.Note_TABLE} WHERE id = ?', [id]);
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<List<Notes>> getAllNotes() async {
    try {
      var dbClient = await con.db;
      var res = await dbClient.query(Dbname.Note_TABLE);

      List<Notes> list =
          res.isNotEmpty ? res.map((c) => Notes.fromMap(c)).toList() : [];
      if (list != null) return list;
      return [];
    } catch (error) {
      return [];
    }
  }

  @override
  Future<int> saveNotes(Notes notes) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.insert(Dbname.Note_TABLE, notes.toMap());
      return res;
    } catch (error) {
      return -1;
    }
  }

  @override
  Future<int> updateNotes(Notes notes) async {
    try {
      var dbClient = await con.db;
      int res = await dbClient.update(Dbname.Note_TABLE, notes.toMap(),
          where: "id = ?", whereArgs: [notes.id]);
      return res;
    } catch (error) {
      return -1;
    }
  }
}
