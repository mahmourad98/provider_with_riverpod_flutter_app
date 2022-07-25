import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled04/data/models/category/category_model.dart';
import 'package:untitled04/data/models/product/product_model.dart';
import 'package:untitled04/data/repositories/categories/categories_repository.dart';
import 'package:untitled04/data/repositories/products/products_repository.dart';

class ProductsListViewModel extends StateNotifier<ProductsListState>{
  final ProductsRepository productsRepository;
  var products = <Product>[];

  ProductsListViewModel({
    required this.productsRepository,
  }) : super(const ProductsListStateLoadedSuccess(products: [],),){
    //loadCategories();
  }

  void _loadState(ProductsListState newState,){
    this.state = newState;
  }

  void loadProducts() async{
    _loadState(const ProductsListStateLoading(),);
    await productsRepository.getAllProducts().then(
      (dynamic result,){
        products = result;
        _loadState(ProductsListStateLoadedSuccess(products: (result as List<Product>),),);
      },
    ).onError(
      (error, stackTrace){
        _loadState(ProductsListStateLoadedError(errorMessage: error.toString(),),);
      },
    );
  }

  void loadSearchProducts(String searchValue,) async{
    _loadState(const ProductsListStateLoading(),);
    final results =  products.where((element, ) => element.title?.startsWith(searchValue) ?? false).toList();
    if(searchValue.isEmpty || results.isEmpty){
      _loadState(ProductsListStateLoadedSuccess(products: products,),);
    }else{
      _loadState(ProductsListStateLoadedSuccess(products: results,),);
    }
  }
}

abstract class ProductsListState{
  const ProductsListState();
}

class ProductsListStateLoading extends ProductsListState{
  const ProductsListStateLoading();
}

class ProductsListStateLoadedSuccess extends ProductsListState{
  final List<Product> products;
  const ProductsListStateLoadedSuccess({required this.products,});
}

class ProductsListStateLoadedError extends ProductsListState{
  final String errorMessage;
  const ProductsListStateLoadedError({required this.errorMessage,});
}