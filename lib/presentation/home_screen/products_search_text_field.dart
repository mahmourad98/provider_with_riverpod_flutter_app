import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:untitled04/data/repositories/products/products_repository.dart';
import 'package:untitled04/presentation/home_screen/products_list_view_model.dart';
import '../../data/repositories/categories/categories_repository.dart';
import '../cart_screen/cart_screen_view.dart';
import 'categories_list_view_model.dart';

class ProductsSearchTextField extends ConsumerWidget{
  final StateNotifierProvider<ProductsListViewModel, ProductsListState>? productsListViewModel;
  const ProductsSearchTextField({Key? key, required this.productsListViewModel,}) : super(key: key,);

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    return TextFormField(
      onChanged: (value,){
        ref.read(productsListViewModel!.notifier,).loadSearchProducts(value.toString(),);
      },
    );
  }

}