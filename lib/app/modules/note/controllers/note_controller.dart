import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/core/repositories/note_repositories.dart';
import 'package:pasuhisab/app/data/model/note_model.dart';

class NoteController extends GetxController {
  NoteRepo noteRepo = new NoteRepositories();
  RxBool isloading = false.obs;
  RxList<Notes> notelist = List<Notes>.empty(growable: true).obs;

  @override
  void onInit() {
    super.onInit();
    // getAllNotes();
  }

  getAllNotes() async {
    isloading.toggle();
    List<Notes> datalist = await noteRepo.getAllNotes();
    if (datalist != null) notelist = datalist.obs;
    isloading.toggle();
  }

  deleteNote(Notes note, BuildContext context) async {
    int res = await noteRepo.deleteNotes(note.id);
    if (res > 0) {
      notelist.remove(note);
    }
  }

  @override
  void onReady() {
    super.onReady();
    // getAllNotes();
  }

  @override
  void onClose() {}
}
