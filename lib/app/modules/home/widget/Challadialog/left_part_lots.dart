import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/category.dart';
import 'package:pasuhisab/app/modules/home/controllers/add_chicks_controller.dart';
import 'package:pasuhisab/app/modules/widgets/list_items/category_list_items.dart';

class AddLotLeftWidget extends StatelessWidget {
  const AddLotLeftWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChicksRecordController>();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(SizeConfig.heightMultiplier / 1.9),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius))),
          child: Text(
            selectCategory.tr,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.textMultiplier),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: challaCategoryList.length,
          itemBuilder: (context, index) {
            Category cat = challaCategoryList[index];

            return InkWell(
              onTap: () {
                controller.categoryString.value = cat.categoryname;
                controller.challaId = cat.id;
              },
              child: Obx(() => controller.categoryString.value != ''
                  ? CategoryItems(
                      image: cat.image,
                      name: cat.categoryname,
                      controller: controller,
                      id: cat.id,
                    )
                  : CategoryItems(
                      image: cat.image,
                      name: cat.categoryname,
                      controller: controller,
                      id: cat.id,
                    )),
            );
          },
          shrinkWrap: true,
        ),
      ],
    );
  }
}
