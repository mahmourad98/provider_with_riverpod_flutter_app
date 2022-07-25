import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category {
  String? categoryId;
  String? categoryName;
  String? categorySlug;
  List<String>? productIds;

  Category({
    this.categoryId, this.categoryName, this.categorySlug, this.productIds
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json,);

  Map<String, dynamic> toJson() => _$CategoryToJson(this,);
}