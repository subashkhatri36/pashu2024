import 'dart:convert';

class OtherModel {
  int id;
  final bool inout;
  final int total;
  final int challid;
  final String remarks;
  final DateTime enterdate;
  OtherModel({
    this.id = 0,
    required this.inout,
    required this.total,
    required this.challid,
    required this.remarks,
    required this.enterdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'inout': inout,
      'total': total,
      'challid': challid,
      'remarks': remarks,
      'enterdate': enterdate.millisecondsSinceEpoch,
    };
  }

  factory OtherModel.fromMap(Map<String, dynamic> map) {
    return OtherModel(
      id: map['id'],
      inout: map['inout'] == 0 ? false : true,
      total: map['total'],
      challid: map['challid'],
      remarks: map['remarks'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OtherModel.fromJson(String source) =>
      OtherModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OtherModel &&
        other.id == id &&
        other.inout == inout &&
        other.total == total &&
        other.challid == challid &&
        other.remarks == remarks &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        inout.hashCode ^
        total.hashCode ^
        challid.hashCode ^
        remarks.hashCode ^
        enterdate.hashCode;
  }
}
