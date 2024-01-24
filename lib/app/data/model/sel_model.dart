import 'dart:convert';

import 'package:flutter/foundation.dart';

class Sel {
  final int qty;
  final double kg;
  Sel({
    required this.qty,
    required this.kg,
  });

  Map<String, dynamic> toMap() {
    return {
      'qty': qty,
      'kg': kg,
    };
  }

  factory Sel.fromMap(Map<String, dynamic> map) {
    return Sel(
      qty: map['qty'],
      kg: map['kg'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Sel.fromJson(String source) => Sel.fromMap(json.decode(source));
}
