import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/note_repositories.dart';
import 'package:pasuhisab/app/data/model/note_model.dart';

class AddnoteController extends GetxController {
  NoteRepo noteRepo = new NoteRepositories();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  loadData(Notes n) {
    titleController.text = n.title;
    descriptionController.text = n.remarks;
  }

  saveNotes() async {
    if (formkey.currentState?.validate() ?? false) {
      Notes n = new Notes(
          title: titleController.text,
          remarks: descriptionController.text,
          enterdate: DateTime.now());
      int res = await noteRepo.saveNotes(n);
      if (res > 0) {
        clearnotes();
        Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
      } else
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }

  updateNote(int id) async {
    Notes n = new Notes(
        id: id,
        title: titleController.text,
        remarks: descriptionController.text,
        enterdate: DateTime.now());
    int res = await noteRepo.updateNotes(n);
    if (res > 0) {
      Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
      clearnotes();
    } else
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
  }

  @override
  void onReady() {
    super.onReady();
  }

  clearnotes() {
    titleController.text = '';
    descriptionController.text = '';
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
  }
}
