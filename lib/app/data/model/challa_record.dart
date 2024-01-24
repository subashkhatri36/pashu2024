import 'dart:convert';

class ChallaRecord {
  int id;
  final int categoryid;
  final String billno;
  final int qty;
  final int rate;

  // final bool finished;
  final bool eggs;
  final int total;
  final DateTime enterdate;

  ChallaRecord({
    this.id = 0,
    required this.categoryid,
    required this.qty,
    required this.rate,
    this.billno = '',
    this.eggs = false,
    this.total = 0,
    required this.enterdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryid': categoryid,
      'billno': billno,
      'qty': qty,
      'rate': rate,
      'eggs': eggs,
      'total': total,
      'enterdate': enterdate.millisecondsSinceEpoch,
    };
  }

  factory ChallaRecord.fromMap(Map<String, dynamic> map) {
    return ChallaRecord(
      id: map['id'],
      categoryid: map['categoryid'],
      billno: map['billno'] ?? '',
      qty: map['qty'],
      rate: map['rate'],
      eggs: map['eggs'] == 0 ? false : true,
      total: map['total'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChallaRecord.fromJson(String source) =>
      ChallaRecord.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChallaRecord &&
        other.id == id &&
        other.categoryid == categoryid &&
        other.billno == billno &&
        other.qty == qty &&
        other.rate == rate &&
        other.eggs == eggs &&
        other.total == total &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categoryid.hashCode ^
        billno.hashCode ^
        qty.hashCode ^
        rate.hashCode ^
        eggs.hashCode ^
        total.hashCode ^
        enterdate.hashCode;
  }
}
