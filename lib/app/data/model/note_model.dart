import 'dart:convert';

class Notes {
  int id;
  final String title;
  final String remarks;
  final DateTime enterdate;
  Notes(
      {this.id = 0,
      required this.title,
      required this.remarks,
      required this.enterdate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'remarks': remarks,
      'enterdate': enterdate.millisecondsSinceEpoch,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'],
      title: map['title'],
      remarks: map['remarks'],
      enterdate: DateTime.fromMillisecondsSinceEpoch(map['enterdate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) => Notes.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Notes &&
        other.id == id &&
        other.title == title &&
        other.remarks == remarks &&
        other.enterdate == enterdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ remarks.hashCode ^ enterdate.hashCode;
  }
}
