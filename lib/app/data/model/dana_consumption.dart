import 'dart:convert';

class DanaConsumption {
  final int id;
  final int dana;
  final int qty;
  final int challid;
  final DateTime enterdate;
  DanaConsumption({
    this.id = 0,
    required this.challid,
    required this.dana,
    required this.qty,
    required this.enterdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dana': dana,
      'qty': qty,
      'challid': challid,
      'enterdate': enterdate.millisecondsSinceEpoch,
    };
  }

  factory DanaConsumption.fromMap(Map<String, dynamic> map) {
    return DanaConsumption(
      id: map['id'],
      dana: map['dana'],
      qty: map['qty'],
      challid: map['challid'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DanaConsumption.fromJson(String source) =>
      DanaConsumption.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DanaConsumption &&
        other.id == id &&
        other.dana == dana &&
        other.qty == qty &&
        other.challid == challid &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dana.hashCode ^
        qty.hashCode ^
        challid.hashCode ^
        enterdate.hashCode;
  }
}
