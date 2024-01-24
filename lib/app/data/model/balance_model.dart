import 'dart:convert';

class Balance {
  int id;
  final int total;
  final String remarks;
  final DateTime enterdate;
  Balance({
    this.id = 0,
    required this.total,
    required this.remarks,
    required this.enterdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'total': total,
      'remarks': remarks,
      'enterdate': enterdate.millisecondsSinceEpoch,
    };
  }

  factory Balance.fromMap(Map<String, dynamic> map) {
    return Balance(
      id: map['id'],
      total: map['total'],
      remarks: map['remarks'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Balance.fromJson(String source) =>
      Balance.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Balance &&
        other.id == id &&
        other.total == total &&
        other.remarks == remarks &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^ total.hashCode ^ remarks.hashCode ^ enterdate.hashCode;
  }
}
