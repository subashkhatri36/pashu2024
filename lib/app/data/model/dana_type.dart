import 'dart:convert';

class DanaType {
  final int id;
  final String danaType;
  DanaType({
    required this.id,
    required this.danaType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'danaType': danaType,
    };
  }

  factory DanaType.fromMap(Map<String, dynamic> map) {
    return DanaType(
      id: map['id'],
      danaType: map['danaType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DanaType.fromJson(String source) =>
      DanaType.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DanaType && other.id == id && other.danaType == danaType;
  }

  @override
  int get hashCode => id.hashCode ^ danaType.hashCode;
}
