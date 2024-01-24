import 'dart:convert';

class Settings {
  //7 days free trial and if they are online then 2 month free trial;
  //price change notification
  bool datetypeNepali; //english date or nepali to record
  bool languageNepali;
  bool themelight;
  bool autobackup; //clear whole data after finished of that lot;
  int id;
  Settings({
    this.id = 0,
    this.datetypeNepali = true,
    this.languageNepali = false,
    this.themelight = true,
    this.autobackup = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'datetypeNepali': datetypeNepali,
      'languageNepali': languageNepali,
      'themelight': themelight,
      'autobackup': autobackup,
      'id': id,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      datetypeNepali: map['datetypeNepali'] == 0 ? false : true,
      languageNepali: map['languageNepali'] == 0 ? false : true,
      themelight: map['themelight'] == 0 ? false : true,
      autobackup: map['autobackup'] == 0 ? false : true,
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Settings &&
        other.datetypeNepali == datetypeNepali &&
        other.languageNepali == languageNepali &&
        other.themelight == themelight &&
        other.autobackup == autobackup &&
        other.id == id;
  }

  @override
  int get hashCode {
    return datetypeNepali.hashCode ^
        languageNepali.hashCode ^
        themelight.hashCode ^
        autobackup.hashCode ^
        id.hashCode;
  }
}
