import 'dart:convert';

class Labor {
  int id;
  final int challid;
  final String remarks;
  final int total;
  final DateTime enterdate;
  Labor({
    this.id = 0,
    required this.challid,
    required this.remarks,
    required this.total,
    required this.enterdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'challid': challid,
      'remarks': remarks,
      'total': total,
      'enterdate': enterdate.millisecondsSinceEpoch,
    };
  }

  factory Labor.fromMap(Map<String, dynamic> map) {
    return Labor(
      id: map['id'],
      challid: map['challid'],
      remarks: map['remarks'],
      total: map['total'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Labor.fromJson(String source) => Labor.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Labor &&
        other.id == id &&
        other.challid == challid &&
        other.remarks == remarks &&
        other.total == total &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        challid.hashCode ^
        remarks.hashCode ^
        total.hashCode ^
        enterdate.hashCode;
  }
}
