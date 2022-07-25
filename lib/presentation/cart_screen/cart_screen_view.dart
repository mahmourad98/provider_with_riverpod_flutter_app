import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:untitled04/data/repositories/categories/categories_repository.dart';
import '../../data/models/product/product_model.dart';
import 'cart_list_view_model.dart';

final cartProductsListViewModel = StateNotifierProvider<CartListViewModel, CartListState>(
  (ref,) => CartListViewModel()
);

class CartScreenView extends ConsumerWidget {
  const CartScreenView({Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final state = ref.watch(cartProductsListViewModel);
    return Scaffold(
      appBar: AppBar(
        title: const Text("CART",),
      ),
      body: resultOfState(state,),
    );
  }

  resultOfState(CartListState state,){
    if(state is CartListStateLoadedSuccess){
      return ListView.builder(
        shrinkWrap: true,
        primary: true,
        scrollDirection: Axis.vertical,
        itemCount: state.cartProducts.length,
        itemBuilder: (buildContext, itemIndex,){
          return SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      "${(state.cartProducts[itemIndex]['product']! as Product).title}",
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
                        "${(state.cartProducts[itemIndex]['product'] as Product).price!} \$",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0,),
                      child: Text(
                          "${(state.cartProducts[itemIndex]['quantity'] as int)}"
                      ),
                    ),
                  ),
                ],
              )
          );
        },
      );
    }
    else if(state is CartListStateLoadedError){
      return Center(child: Text(state.errorMessage,),);
    }
    else{
      return const Center(child: CircularProgressIndicator(),);
    }
  }
}

