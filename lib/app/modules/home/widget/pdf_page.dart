import 'dart:io';

import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

orderPdfView(context, String title, HomeController controller) async {
  print('Here it is');
  final Document pdf = Document();
  int pl = (controller.totalIncome.value + controller.balance.value) -
      controller.totalExpenditure.value;
  pdf.addPage(
    Page(
      orientation: PageOrientation.natural,
      // pageFormat: PdfPageFormat.a4,
      build: (context) => Column(
        children: [
          divider(500),
          spaceDivider(5),
          Text(
            title,
            style: TextStyle(fontSize: borderRadius, color: PdfColors.grey),
          ),
          spaceDivider(5),
          divider(500),
          spaceDivider(30),
          Row(
            children: [
              Text(
                "Made By Pashu Hisab",
                textAlign: TextAlign.left,
                style: textStyle1(),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                profit.tr + ' & ' + loss.tr,
                textAlign: TextAlign.left,
                style: textStyle1(),
              ),
            ],
          ),
          spaceDivider(20),
          textRow([particular.tr, amount.tr], textStyle1()),
          textRow(
              [balance.tr, controller.balance.value.toString()], textStyle2()),
          textRow([
            total.tr + ' ' + income.tr + '(+)',
            controller.totalIncome.value.toString()
          ], textStyle2()),
          textRow([
            total.tr + ' ' + expenses.tr + '(-)',
            controller.totalExpenditure.value.toString()
          ], textStyle2()),
          textRow([pl > 0 ? profit.tr : loss.tr, pl.abs().toString()],
              textStyle2()),
          spaceDivider(20),
          Row(
            children: [
              Text(
                expenses.tr,
                textAlign: TextAlign.left,
                style: textStyle1(),
              ),
            ],
          ),
          Container(
            color: PdfColors.white,
            child: Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                tableRow(
                    [particular.tr, qty.tr, rate.tr, total.tr], textStyle1()),
                for (var items in controller.totalExpenditureList)
                  if (items.total > 0)
                    tableRow([
                      items.name,
                      items.qty.toString(),
                      items.rate.toString(),
                      items.total.toString()
                    ], textStyle2()),
                tableRow([
                  total.tr + ' ' + expenses.tr,
                  '',
                  '',
                  controller.totalExpenditure.value.toString()
                ], textStyle1()),
              ],
            ),
          ),
          spaceDivider(10),

          spaceDivider(10),
          // divider(500),
          // spaceDivider(30),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Container(
          //       width: 250,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           textRow(["Sub Total", "290"], textStyle2()),
          //           textRow(["Discount", "90"], textStyle2()),
          //           divider(500),
          //           textRow(["Grand Total", "200"], textStyle2()),
          //           divider(500),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    ),
  );

  pdf.addPage(Page(
      orientation: PageOrientation.natural,
      // pageFormat: PdfPageFormat.a4,
      build: (context) => Column(children: [
            Row(
              children: [
                Text(
                  income.tr,
                  textAlign: TextAlign.left,
                  style: textStyle1(),
                ),
              ],
            ),
            Container(
              color: PdfColors.white,
              child: Table(
                border: TableBorder.all(color: PdfColors.black),
                children: [
                  tableRow(
                      [particular.tr, qty.tr, rate.tr, total.tr], textStyle1()),
                  for (var items in controller.totalIncomeList)
                    if (items.total > 0)
                      tableRow([
                        items.name,
                        items.qty.toString(),
                        items.rate.toString(),
                        items.total.toString()
                      ], textStyle2()),
                  tableRow([
                    total.tr + ' ' + income.tr,
                    '',
                    '',
                    controller.totalIncome.value.toString()
                  ], textStyle1()),
                ],
              ),
            ),
          ])));
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);

  await file.writeAsBytes((await pdf.save()));
//TODO: WOrk need to do on this
  // Get.to(() => PdfViewer(), arguments: path);
}

Widget divider(double width) {
  return Container(
    height: 3,
    width: width,
    decoration: BoxDecoration(
      color: PdfColors.blue400,
    ),
  );
}

tableRow(List<String> attributes, TextStyle textStyle) {
  return TableRow(
    children: attributes
        .map(
          (e) => Text(
            "  " + e,
            style: textStyle,
          ),
        )
        .toList(),
  );
}

Widget textRow(List<String> titleList, TextStyle textStyle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: titleList
        .map(
          (e) => Text(
            e,
            style: textStyle,
          ),
        )
        .toList(),
  );
}

TextStyle textStyle1() {
  return TextStyle(
    color: PdfColors.grey800,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
}

TextStyle textStyle2() {
  return TextStyle(
    color: PdfColors.grey,
    fontSize: 22,
  );
}

Widget spaceDivider(double height) {
  return SizedBox(height: height);
}
