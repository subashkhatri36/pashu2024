import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/challa_record.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/chicks_dead.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/income_bottom_widget.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/sub_expenses_menu.dart';
import 'package:pasuhisab/app/modules/home/widget/expenditure_summary_widget.dart';
import 'package:pasuhisab/app/modules/home/widget/income_summary_widget.dart';
import 'package:pasuhisab/app/modules/home/widget/infoBanner/info_dashboard.dart';
import 'package:pasuhisab/app/modules/home/widget/menu/main_menu.dart';
import 'package:pasuhisab/app/modules/home/widget/menu/menu_field.dart';
import 'package:pasuhisab/app/modules/home/widget/pdf_page.dart';
import 'package:pasuhisab/app/modules/home/widget/profit_loss_widget.dart';
import 'package:pasuhisab/app/modules/splash/controllers/splash_controller.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/category_items.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.find<HomeController>();
  // final chickController = Get.find<ChicksRecordController>();

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  loaddata() async {
    await controller.loadingChicks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            //Main Menu
            MainMenuHeader(),
            //Main Menu End
            Divider(),
            Obx(
              () => controller.isloading.isTrue
                  ? Expanded(
                      flex: 9,
                      child: (Center(
                        child: CircularProgressIndicator(),
                      )),
                    )
                  : controller.challRecordList == null ||
                          controller.challRecordList.isEmpty ||
                          controller.challRecordList?.length == 0
                      ? Expanded(
                          flex: 9,
                          child: Center(
                            child: Text(
                              addfromtop.tr,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      : Expanded(
                          flex: 9,
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.heightMultiplier,
                              ),
                              LotShowCategory(),
                              Obx(() => controller.challInfoLoading.isTrue
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Column(
                                      children: [
                                        BorderContainer(
                                          colors: Colors.transparent,
                                          widget: Row(
                                            children: [
                                              SingleMenuField(
                                                text: income.tr,
                                                iconData: Icons.file_download,
                                                onPressed: () {
                                                  Get.bottomSheet(
                                                      BottomIncomeWidget());
                                                },
                                              ),
                                              SingleMenuField(
                                                text: expenses.tr,
                                                iconData: Icons.file_upload,
                                                onPressed: () {
                                                  Get.bottomSheet(
                                                      ExpensesMenu());
                                                },
                                              ),
                                              SingleMenuField(
                                                text: chick.tr + ' ' + dead.tr,
                                                iconData: Icons.close,
                                                onPressed: () {
                                                  Get.bottomSheet(ChickDead());
                                                },
                                              ),
                                              SingleMenuField(
                                                text: printing.tr,
                                                iconData: Icons.print,
                                                onPressed: () {
                                                  if (Get.find<
                                                          SplashController>()
                                                      .nepaliLanguage
                                                      .value)
                                                    Get.snackbar('Info',
                                                        'To print report please change language into english');
                                                  else
                                                    orderPdfView(
                                                        context,
                                                        controller.categoryid(controller
                                                                .challRecordList[
                                                                    controller
                                                                        .index]
                                                                .categoryid) +
                                                            ' ' +
                                                            (controller.index +
                                                                    1)
                                                                .toString() +
                                                            ' ' +
                                                            DateFormat.yMd()
                                                                .format(DateTime
                                                                    .now()),
                                                        controller);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),
                                        ProfitAndLoss(),

                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(note.tr + ' ' + clickmessage.tr),

                                        TopGeneralInfoDashBoard(),
                                        SizedBox(
                                          height: SizeConfig.heightMultiplier,
                                        ),
                                        //ChartWidget(),
                                        SizedBox(
                                          height: SizeConfig.heightMultiplier,
                                        ),
                                        TotalExpenditureSummaryWidget(),
                                        SizedBox(
                                          height: SizeConfig.heightMultiplier,
                                        ),
                                        // AdsWidget(),
                                        IncomeSummaryWidget(),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier / 2,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: borderRadius),
                                          child: CustomButton(
                                            borderRadius: 20,
                                            btnColor: Colors.red,
                                            label: finished.tr +
                                                ' ' +
                                                the.tr +
                                                ' ' +
                                                lot.tr,
                                            onPressed: () async {
                                              await controller.deleteChalla(
                                                  context, controller.index);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier / 2,
                                        ),
                                      ],
                                    )),
                            ],
                          )),
                        ),
            ),
          ],
        ),
      )),
    );
  }
}

class LotShowCategory extends StatelessWidget {
  const LotShowCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final controller = Get.find<ChicksRecordController>();
    final hcontroller = Get.find<HomeController>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier / 2),
      height: SizeConfig.heightMultiplier * 3,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: hcontroller.challRecordList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            ChallaRecord element = hcontroller.challRecordList[index];

            return Obx(() => hcontroller.challid.value == element.id
                ? InkWell(
                    onTap: () async {
                      if (hcontroller.challid.value != element.id) {
                        hcontroller.challid.value = element.id;
                        hcontroller.index = index;

                        await hcontroller
                            .loadSingleChallInof(hcontroller.challid.value);
                      }
                    },
                    child: CategoryItem(
                      text: hcontroller.categoryfindbyId(element.categoryid) +
                          ' ' +
                          element.id.toString(),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      hcontroller.challid.value = element.id;
                      hcontroller.index = index;
                      await hcontroller
                          .loadSingleChallInof(hcontroller.challid.value);
                    },
                    child: CategoryItem(
                      text: hcontroller.categoryfindbyId(element.categoryid) +
                          ' ' +
                          element.id.toString(),
                      backgroundColor: Colors.grey,
                    ),
                  ));
          }),
    );
  }
}
