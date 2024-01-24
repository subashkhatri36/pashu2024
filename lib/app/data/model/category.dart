import 'dart:convert';

class Category {
  final int id;
  final String categoryname;
  final String image;

  Category({
    required this.id,
    required this.categoryname,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryname': categoryname,
      'image': image,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      categoryname: map['categoryname'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.categoryname == categoryname &&
        other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ categoryname.hashCode ^ image.hashCode;
}
