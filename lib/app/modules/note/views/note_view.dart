import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/note_model.dart';
import 'package:pasuhisab/app/modules/addnote/bindings/addnote_binding.dart';
import 'package:pasuhisab/app/modules/addnote/views/addnote_view.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/modules/widgets/dialog_box.dart';

import '../controllers/note_controller.dart';

class NoteView extends GetView<NoteController> {
  @override
  Widget build(BuildContext context) {
    controller.getAllNotes();
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
              onPressed: () {
                controller.getAllNotes();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddnoteView(),
              binding: AddnoteBinding(), arguments: [null, 'Add']);
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Obx(() => controller.isloading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : controller.notelist == null
                ? Center(
                    child: Text('No Notes Found'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.notelist.length,
                    itemBuilder: (context, index) {
                      Notes n = controller.notelist[index];
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (val) async {
                          bool d = await dialogBox(context,
                              title: 'Warning !',
                              message: 'Are you sure to delete note.',
                              btnname: 'Delete');
                          if (d) {
                            controller.deleteNote(n, context);
                          }

                          return d;
                        },
                        onDismissed: (DismissDirection direction) async {},
                        secondaryBackground: Container(
                          child: Center(
                            child: Text(
                              delete.tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          color: Colors.red,
                        ),
                        background: Container(),
                        key: ValueKey(n.id),
                        child: BorderContainer(
                            widget: ListTile(
                          onTap: () {
                            Get.to(() => AddnoteView(),
                                binding: AddnoteBinding(),
                                arguments: [n, 'update']);
                          },
                          title: Text(n.title),
                          subtitle: RichText(
                            text: TextSpan(
                                text: n.remarks,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.textMultiplier),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '\n-' +
                                        DateFormat('yyyy-MM-dd ')
                                            .format(n.enterdate)
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                  )
                                ]),
                          ),
                        )),
                      );
                    })),
      ),
    );
  }
}
