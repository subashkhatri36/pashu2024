import 'dart:convert';

class EleModel {
  int id;
  final int rent;
  final int electricity;
  final int water;
  final int challid;
  int total;
  final DateTime enterdate;
  EleModel({
    this.id = 0,
    required this.rent,
    required this.electricity,
    required this.water,
    required this.challid,
    this.total = 0,
    required this.enterdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rent': rent,
      'electricity': electricity,
      'water': water,
      'challid': challid,
      'enterdate': enterdate.millisecondsSinceEpoch,
    };
  }

  factory EleModel.fromMap(Map<String, dynamic> map) {
    return EleModel(
      id: map['id'],
      rent: map['rent'],
      electricity: map['electricity'],
      water: map['water'],
      challid: map['challid'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EleModel.fromJson(String source) =>
      EleModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EleModel &&
        other.id == id &&
        other.rent == rent &&
        other.electricity == electricity &&
        other.water == water &&
        other.challid == challid &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rent.hashCode ^
        electricity.hashCode ^
        water.hashCode ^
        challid.hashCode ^
        enterdate.hashCode;
  }
}
