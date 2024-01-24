import 'dart:convert';

class EggModel {
  int id;
  final int qty;
  final int rate;
  final int challid;
  int total;
  final DateTime enterdate;
  EggModel({
    this.id = 0,
    required this.qty,
    required this.rate,
    required this.challid,
    this.total = 0,
    required this.enterdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'qty': qty,
      'rate': rate,
      'challid': challid,
      'enterdate': enterdate.millisecondsSinceEpoch,
    };
  }

  factory EggModel.fromMap(Map<String, dynamic> map) {
    return EggModel(
      id: map['id'],
      qty: map['qty'],
      rate: map['rate'],
      challid: map['challid'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EggModel.fromJson(String source) =>
      EggModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EggModel &&
        other.id == id &&
        other.qty == qty &&
        other.rate == rate &&
        other.challid == challid &&
        other.total == total &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        qty.hashCode ^
        rate.hashCode ^
        challid.hashCode ^
        total.hashCode ^
        enterdate.hashCode;
  }
}
