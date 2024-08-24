// import 'dart:convert';

// class Category {
//   final int id;
//   final String name;
//   final String image;
//   final String creationAt;
//   final String updatedAt;
//   Category({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.creationAt,
//     required this.updatedAt,
//   });

//   Category copyWith({
//     int? id,
//     String? name,
//     String? image,
//     String? creationAt,
//     String? updatedAt,
//   }) {
//     return Category(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       image: image ?? this.image,
//       creationAt: creationAt ?? this.creationAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'image': image,
//       'creationAt': creationAt,
//       'updatedAt': updatedAt,
//     };
//   }

//   factory Category.fromMap(Map<String, dynamic> map) {
//     return Category(
//       id: map['id']?.toInt() ?? 0,
//       name: map['name'] ?? '',
//       image: map['image'] ?? '',
//       creationAt: map['creationAt'] ?? '',
//       updatedAt: map['updatedAt'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Category.fromJson(String source) => Category.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Category(id: $id, name: $name, image: $image, creationAt: $creationAt, updatedAt: $updatedAt)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
  
//     return other is Category &&
//       other.id == id &&
//       other.name == name &&
//       other.image == image &&
//       other.creationAt == creationAt &&
//       other.updatedAt == updatedAt;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//       name.hashCode ^
//       image.hashCode ^
//       creationAt.hashCode ^
//       updatedAt.hashCode;
//   }
// }