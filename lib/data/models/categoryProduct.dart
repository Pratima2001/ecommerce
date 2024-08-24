import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'category.dart';

class CategoryProduct {
  final int id;
  final String title;
  final int price;
  final String description;
  final List<String> images;
  final String creationAt;
  final String updatedAt;
  final MainCategory category;
  CategoryProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
    required this.category,
  });

  CategoryProduct copyWith({
    int? id,
    String? title,
    int? price,
    String? description,
    List<String>? images,
    String? creationAt,
    String? updatedAt,
    MainCategory? category,
  }) {
    return CategoryProduct(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? this.images,
      creationAt: creationAt ?? this.creationAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'images': images,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
      'category': category.toMap(),
    };
  }

  factory CategoryProduct.fromMap(Map<String, dynamic> map) {
    return CategoryProduct(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      price: map['price']?.toInt() ?? 0,
      description: map['description'] ?? '',
      images: List<String>.from(map['images']),
      creationAt: map['creationAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      category: MainCategory.fromMap(map['category']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryProduct.fromJson(String source) => CategoryProduct.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryProduct(id: $id, title: $title, price: $price, description: $description, images: $images, creationAt: $creationAt, updatedAt: $updatedAt, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CategoryProduct &&
      other.id == id &&
      other.title == title &&
      other.price == price &&
      other.description == description &&
      listEquals(other.images, images) &&
      other.creationAt == creationAt &&
      other.updatedAt == updatedAt &&
      other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      price.hashCode ^
      description.hashCode ^
      images.hashCode ^
      creationAt.hashCode ^
      updatedAt.hashCode ^
      category.hashCode;
  }
}