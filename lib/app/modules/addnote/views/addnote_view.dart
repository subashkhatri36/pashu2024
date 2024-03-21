import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/note/controllers/note_controller.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

import '../controllers/addnote_controller.dart';

class AddnoteView extends GetView<AddnoteController> {
  final arg = Get.arguments;

  @override
  Widget build(BuildContext context) {
    if (arg[0] != null) controller.loadData(arg[0]);
    final hcontroller = Get.find<HomeController>();
    final not = Get.find<NoteController>();
    return Scaffold(
        appBar: AppBar(
          title: Text(arg[1].toString().toLowerCase() == 'add'
              ? addnote.tr
              : updatenote.tr),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(borderRadius / 2),
            child: Form(
              key: controller.formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: controller.titleController,
                    label: title.tr,
                    hintText: title.tr,
                    round: true,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier / 2,
                  ),
                  CustomTextField(
                    controller: controller.descriptionController,
                    label: description.tr,
                    hintText: description.tr,
                    round: true,
                    maxline: 10,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier / 2,
                  ),
                  CustomButton(
                    label: arg[1].toString().toLowerCase() == 'add'
                        ? save.tr
                        : update.tr,
                    btnColor: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if (arg[1].toString().toLowerCase() == 'add')
                        await controller.saveNotes();
                      else
                        await controller.updateNote(arg[0].id);

                      await not.getAllNotes();
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
