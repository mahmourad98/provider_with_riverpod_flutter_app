part of 'product_model.dart';

Product _$ProductFromJson(Map<String, dynamic> json,) => Product(
  id: json['_id'].toString(),
  title: json['title'].toString(),
  price: (json['price'] as int).toDouble(),
  category: json['category'] != null ? Category.fromJson(json['category'],) : null,
  description: json['description'].toString(),
  createdBy: json['createdBy'].toString(),
  createdAt: json['createdAt'].toString(),
  updatedAt: json['updatedAt'].toString(),
  slug: json['slug'].toString(),
);

Map<String, dynamic> _$ProductToJson(Product instance,) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'price': instance.price,
  'category': instance.category,
  'description': instance.description,
  'createdBy': instance.createdBy,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'slug': instance.slug,
  'image': instance.imageUrl,
};