import 'dart:convert';

import 'package:flutter/foundation.dart';

class TotalModel {
  String name;
  final int qty;
  final int rate;
  final int total;
  final VoidCallback? onTap;
  TotalModel({
    this.name = '',
    required this.qty,
    required this.rate,
    required this.total,
    this.onTap,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'qty': qty,
      'rate': rate,
      'total': total,
    };
  }

  factory TotalModel.fromMap(Map<String, dynamic> map) {
    return TotalModel(
      name: map['name'],
      qty: map['qty'],
      rate: map['rate'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TotalModel.fromJson(String source) =>
      TotalModel.fromMap(json.decode(source));
}
