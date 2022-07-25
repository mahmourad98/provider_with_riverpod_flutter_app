import 'dart:developer';
import 'package:untitled04/data/models/category/category_model.dart';
import '../../../domain/categories/categories_domain.dart';

class CategoriesRepository {
  late final CategoriesDomain _categoriesDomain;

  CategoriesRepository({required categoriesDomain,}){
    this._categoriesDomain = categoriesDomain;
  }

  Future<List<Category>> getAllCategories() async{
    final results = await this._categoriesDomain.getAllCategories() as List<Map<String, dynamic>>;
    final resultsAsModels = (results).map(
      (element,){
        return Category.fromJson(element,);
      }
    ).toList();
    log('current orders: ${resultsAsModels.length}', name: "getAllCategories/CategoriesRepository");
    return resultsAsModels;
  }
}