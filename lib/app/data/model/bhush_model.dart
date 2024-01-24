import 'dart:convert';

class Bhush {
  int id;
  final int challid;
  final int rate;
  final int qty;
  int total;
  final String remarks;

  final DateTime enterdate;
  Bhush({
    this.id = 0,
    required this.challid,
    required this.rate,
    required this.qty,
    this.total = 0,
    required this.remarks,
    required this.enterdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'challid': challid,
      'rate': rate,
      'qty': qty,
      'remarks': remarks,
      'enterdate': enterdate.millisecondsSinceEpoch,
    };
  }

  factory Bhush.fromMap(Map<String, dynamic> map) {
    return Bhush(
      id: map['id'],
      challid: map['challid'],
      rate: map['rate'],
      qty: map['qty'],
      remarks: map['remarks'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bhush.fromJson(String source) => Bhush.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bhush &&
        other.id == id &&
        other.challid == challid &&
        other.rate == rate &&
        other.qty == qty &&
        other.total == total &&
        other.remarks == remarks &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        challid.hashCode ^
        rate.hashCode ^
        qty.hashCode ^
        total.hashCode ^
        remarks.hashCode ^
        enterdate.hashCode;
  }
}
