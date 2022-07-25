import 'dart:developer';
import 'package:untitled04/data/models/category/category_model.dart';
import 'package:untitled04/data/models/product/product_model.dart';
import '../../../domain/product/products_domain.dart';

class ProductsRepository {
  late final ProductsDomain _productsDomain;

  ProductsRepository({required productsDomain,}){
    this._productsDomain = productsDomain;
  }

  Future<List<Product>> getAllProducts() async{
    final results = await this._productsDomain.getAllProducts();
    final resultsAsModels = (results as List).map(
      (element,){
        return Product.fromJson(element,);
      }
    ).toList();
    log('current products: ${resultsAsModels.length}', name: "getAllProducts/ProductsRepository");
    return resultsAsModels;
  }

  Future<List<Product>> getProductsOfCategory(c) async{
    final results = await this._productsDomain.getAllProducts();
    final resultsAsModels = (results as List).map(
            (element,){
          return Product.fromJson(element,);
        }
    ).toList();
    log('current products: ${resultsAsModels.length}', name: "getAllProducts/ProductsRepository");
    return resultsAsModels;
  }
}