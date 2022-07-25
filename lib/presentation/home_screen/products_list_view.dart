import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:untitled04/data/repositories/products/products_repository.dart';
import 'package:untitled04/presentation/home_screen/products_list_view_model.dart';
import '../../data/repositories/categories/categories_repository.dart';
import '../cart_screen/cart_screen_view.dart';
import 'categories_list_view_model.dart';

class ProductsListView extends ConsumerWidget{
  final StateNotifierProvider<ProductsListViewModel, ProductsListState>? productsListViewModel;

  const ProductsListView({Key? key, required this.productsListViewModel,}) : super(key: key,);

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    log("we were built", name:'build/CategoriesListView',);
    //ref.read(_categoriesListViewModel!.notifier).loadCategories();
    //ref.listen(_categoriesListViewModel!, (previous, next) { });
    final state = ref.watch(productsListViewModel!);
    if(state is ProductsListStateLoadedSuccess){
      return ListView.builder(
        shrinkWrap: true,
        primary: true,
        scrollDirection: Axis.vertical,
        itemCount: state.products.length,
        itemBuilder: (buildContext, itemIndex,){
          return SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.remove,),
                    onPressed: (){
                      ref.read(cartProductsListViewModel.notifier).removeQuantity(state.products[itemIndex],);
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      state.products[itemIndex].imageUrl ?? 'https://i.ibb.co/b6537bn/28966856.jpg',
                    ),
                  )
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    state.products[itemIndex].title!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "${state.products[itemIndex].price!} \$",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.add,),
                    onPressed: (){
                      ref.read(cartProductsListViewModel.notifier).addQuantity(state.products[itemIndex],);
                    },
                  ),
                ),
              ],
            )
          );
        },
      );
    }
    else if(state is ProductsListStateLoadedError){
      return Center(child: Text(state.errorMessage,),);
    }
    else{
      return const Center(child: CircularProgressIndicator(),);
    }
  }

}