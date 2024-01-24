import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({
    Key? key,
    required this.nepalidate,
    required this.controller,
  }) : super(key: key);

  final controller;
  final bool nepalidate;
  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  String today = ''; // DateTime.now().subtract(Duration(days: 1)).toString();

  String formattedDate = '';
  int day = 0;
  //DateTime.parse(NepaliDateFormat.yMd().format(NepaliDateTime.now()))
  changeYesterday() {
    formattedDate = widget.nepalidate
        ? DateFormat('yyyy-MM-dd ')
            .format(NepaliDateTime.now().subtract(Duration(days: ++day)))
        : DateFormat('yyyy-MM-dd ')
            .format(DateTime.now().subtract(Duration(days: ++day)));
    widget.controller.todayDate.value = formattedDate;
  }

  changeNextDay() {
    if (day > 0) {
      formattedDate = widget.nepalidate
          ? DateFormat('yyyy-MM-dd ')
              .format(NepaliDateTime.now().subtract(Duration(days: --day)))
          : DateFormat('yyyy-MM-dd ')
              .format(DateTime.now().subtract(Duration(days: --day)));
      widget.controller.todayDate.value = formattedDate;
    }
  }

  @override
  void initState() {
    today = widget.nepalidate
        ? DateFormat('yyyy-MM-dd ').format(NepaliDateTime.now())
        : DateFormat('yyyy-MM-dd ').format(DateTime.now());
    widget.controller.todayDate.value = today;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              changeYesterday();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        Obx(() => Text(widget.controller.todayDate.value)),
        IconButton(
            onPressed: () {
              changeNextDay();
            },
            icon: Icon(Icons.arrow_forward_ios))
      ],
    );
  }
}
