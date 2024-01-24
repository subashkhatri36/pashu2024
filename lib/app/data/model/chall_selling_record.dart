import 'dart:convert';

class Selling {
  final int id;
  final int challid;
  final String billno;
  final int piece;
  final double kg;
  final int rate;
  double total;
  double average;
  final String remarks;
  final int travel;
  final DateTime enterdate;
  Selling({
    this.id = 0,
    required this.challid,
    required this.billno,
    required this.piece,
    required this.kg,
    required this.rate,
    this.total = 0,
    this.average = 0,
    required this.remarks,
    required this.travel,
    required this.enterdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'challid': challid,
      'billno': billno,
      'piece': piece,
      'kg': kg,
      'rate': rate,
      'remarks': remarks,
      'travel': travel,
      'enterdate': enterdate.millisecondsSinceEpoch,
    };
  }

  factory Selling.fromMap(Map<String, dynamic> map) {
    return Selling(
      id: map['id'],
      challid: map['challid'],
      billno: map['billno'],
      piece: map['piece'],
      kg: double.parse(map['kg'].toString()),
      rate: map['rate'],
      remarks: map['remarks'],
      travel: map['travel'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Selling.fromJson(String source) =>
      Selling.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Selling &&
        other.id == id &&
        other.challid == challid &&
        other.billno == billno &&
        other.piece == piece &&
        other.kg == kg &&
        other.rate == rate &&
        other.total == total &&
        other.remarks == remarks &&
        other.travel == travel &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        challid.hashCode ^
        billno.hashCode ^
        piece.hashCode ^
        kg.hashCode ^
        rate.hashCode ^
        total.hashCode ^
        remarks.hashCode ^
        travel.hashCode ^
        enterdate.hashCode;
  }
}
