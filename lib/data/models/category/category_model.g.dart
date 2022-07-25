part of 'category_model.dart';

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  categoryId: json['_id'].toString(),
  categoryName: json['name'].toString(),
  categorySlug: json['slug'].toString(),
  productIds: json['products'] != null ? List<String>.from(json['products']) : null,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  '_id': instance.categoryId,
  'name': instance.categoryName,
  'slug': instance.categorySlug,
  'products': instance.productIds,
};