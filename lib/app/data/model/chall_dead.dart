import 'dart:convert';

class ChallDead {
  final int id;
  final int challid;
  final int qty;
  final int price;
  double total;
  final String remarks;
  final DateTime enterdate;
  ChallDead({
    this.id = 0,
    this.remarks = '',
    this.total = 0,
    required this.challid,
    required this.qty,
    required this.price,
    required this.enterdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'challid': challid,
      'qty': qty,
      'price': price,
      'remarks': remarks,
      'enterdate': enterdate.millisecondsSinceEpoch,
    };
  }

  factory ChallDead.fromMap(Map<String, dynamic> map) {
    return ChallDead(
      id: map['id'],
      challid: map['challid'],
      qty: map['qty'],
      price: map['price'],
      remarks: map['remarks'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChallDead.fromJson(String source) =>
      ChallDead.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChallDead &&
        other.id == id &&
        other.challid == challid &&
        other.qty == qty &&
        other.price == price &&
        other.remarks == remarks &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        challid.hashCode ^
        qty.hashCode ^
        price.hashCode ^
        remarks.hashCode ^
        enterdate.hashCode;
  }
}
