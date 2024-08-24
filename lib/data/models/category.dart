import 'dart:convert';

class MainCategory {
  final int id;
  final String name;
  final String image;

  MainCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  MainCategory copyWith({
    int? id,
    String? name,
    String? image,
    String? creationAt,
    String? updatedAt,
  }) {
    return MainCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory MainCategory.fromMap(Map<String, dynamic> map) {
    return MainCategory(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MainCategory.fromJson(String source) =>
      MainCategory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(id: $id, name: $name, image: $image ';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MainCategory &&
        other.id == id &&
        other.name == name &&
        other.image == image
       ;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode
       ;
  }
}
