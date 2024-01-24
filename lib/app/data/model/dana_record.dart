import 'dart:convert';

class Dana {
  int id;
  final String dana;
  final int challid;
  final String billno;
  final int qty;
  final int rate;
  int consume;
  bool finished;
  int total;
  int dreturn;
  final DateTime enterdate;
  Dana({
    this.id = 0,
    this.consume = 0,
    required this.dana,
    required this.challid,
    required this.billno,
    required this.qty,
    required this.rate,
    this.total = 0,
    this.finished = false,
    this.dreturn = 0,
    required this.enterdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dana': dana,
      'challid': challid,
      'billno': billno,
      'qty': qty,
      'rate': rate,
      'dreturn': dreturn,
      'enterdate': enterdate?.millisecondsSinceEpoch,
    };
  }

  factory Dana.fromMap(Map<String, dynamic> map) {
    return Dana(
      id: map['id'],
      dana: map['dana'],
      challid: map['challid'],
      billno: map['billno'],
      qty: map['qty'],
      rate: map['rate'],
      dreturn: map['dreturn'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dana.fromJson(String source) => Dana.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Dana &&
        other.id == id &&
        other.dana == dana &&
        other.challid == challid &&
        other.billno == billno &&
        other.qty == qty &&
        other.rate == rate &&
        other.finished == finished &&
        other.dreturn == dreturn &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dana.hashCode ^
        challid.hashCode ^
        billno.hashCode ^
        qty.hashCode ^
        rate.hashCode ^
        finished.hashCode ^
        dreturn.hashCode ^
        enterdate.hashCode;
  }
}
