import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled04/data/models/category/category_model.dart';
import 'package:untitled04/data/models/product/product_model.dart';
import 'package:untitled04/data/repositories/categories/categories_repository.dart';

class CartListViewModel extends StateNotifier<CartListState>{
  final cartProducts = <Map<String, dynamic>>[];
  CartListViewModel() : super(const CartListStateLoadedError(errorMessage: "There Is No Items.",),){
    //loadCategories();
  }

  void _loadState(CartListState newState,){
    this.state = newState;
  }

  void loadProducts({required List<Map<String, dynamic>> products,}) async{
    // (state as CartListStateLoadedSuccess).cartProducts
    _loadState(const CartListStateLoading(),);
    if(cartProducts.isEmpty){
      _loadState(const CartListStateLoadedError(errorMessage: "There Is No Items.",),);
    }else{
      _loadState(CartListStateLoadedSuccess(cartProducts: cartProducts,),);
    }
  }

  addQuantity(Product product,){
    if(checkIfWeHaveTheProductInCart(product.id!,)){
      cartProducts.where((element,) => element['product'].id == product.id,).first['quantity']++;
    }else{
      cartProducts.add(
        {'product': product, 'quantity': 1,}
      );
    }
    loadProducts(products: this.cartProducts,);
  }

  bool checkIfWeHaveTheProductInCart(String id,){
    return cartProducts.where((element,) => element['product'].id == id,).length == 1;
  }

  removeQuantity(Product product,){
    if(checkIfTheProductQuantityIsOne(product.id!)){
      cartProducts.removeWhere((element,) => element['product'].id == product.id,);
    }else{
      cartProducts.where((element,) => element['product'].id == product.id,).first['quantity']--;
    }
    loadProducts(products: this.cartProducts,);
  }

  checkIfTheProductQuantityIsOne(String id,){
    return cartProducts.where((element,) => element['product'].id == id,).first['quantity'] == 1;
  }
}

abstract class CartListState{
  const CartListState();
}

class CartListStateLoading extends CartListState{
  const CartListStateLoading();
}

class CartListStateLoadedSuccess extends CartListState{
  final List<Map<String, dynamic>> cartProducts;
  const CartListStateLoadedSuccess({required this.cartProducts,});
}

class CartListStateLoadedError extends CartListState{
  final String errorMessage;
  const CartListStateLoadedError({required this.errorMessage,});
}