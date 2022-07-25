import 'package:json_annotation/json_annotation.dart';
import '../category/category_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  String? id;
  String? title;
  double? price;
  Category? category;
  String? description;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? slug;
  String? imageUrl;

  Product({
    this.id, this.title, this.price, this.category, this.description, this.createdBy,
    this.createdAt, this.updatedAt, this.slug, this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json,);

  Map<String, dynamic> toJson() => _$ProductToJson(this,);
}