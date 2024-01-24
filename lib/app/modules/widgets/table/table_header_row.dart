import 'package:flutter/material.dart';
import 'package:pasuhisab/app/modules/widgets/table/single_column_table.dart';

///

class TableHeaderAndRow extends StatelessWidget {
  const TableHeaderAndRow({
    Key? key,
    this.ontap,
    this.header = false,
    required this.particular,
    required this.qty,
    required this.rate,
    required this.total,
  }) : super(key: key);
  final bool header;
  final String particular;
  final String qty;
  final String rate;
  final String total;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap ?? null,
      child: Column(
        children: [
          Row(
            children: [
              SingelColumnTable(text: particular, header: header, fl: 4),
              SingelColumnTable(text: qty, header: header, fl: 2),
              SingelColumnTable(text: rate, header: header, fl: 2),
              SingelColumnTable(text: total, header: header, fl: 3),
            ],
          ),
          if (!header) Divider(),
        ],
      ),
    );
  }
}
