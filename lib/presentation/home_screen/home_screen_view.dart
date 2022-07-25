import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart' as provider;
import 'package:untitled04/app/app_route_names.dart';
import 'package:untitled04/data/repositories/products/products_repository.dart';
import 'package:untitled04/presentation/home_screen/products_list_view.dart';
import 'package:untitled04/presentation/home_screen/products_list_view_model.dart';
import 'package:untitled04/presentation/home_screen/products_search_text_field.dart';
import '../../data/repositories/categories/categories_repository.dart';
import 'categories_list_view.dart';
import 'categories_list_view_model.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key,}) : super(key: key,);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final productsListViewModel = StateNotifierProvider<ProductsListViewModel, ProductsListState>(
      (ref,) => ProductsListViewModel(productsRepository: context.read<ProductsRepository>(),)
          ..loadProducts(),
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: (){
              Navigator.of(context,).pushNamed(AppRouteNames.cartScreenRoute);
            },
          ),
        ],
      ),
      drawer: PreferredSize(
        preferredSize: const Size.fromWidth(128.0),
        child: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 32.0,),
              const Padding(
                padding: EdgeInsets.only(right: 16.0, left: 16.0,),
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  height: 8.0, thickness: 2.0, color: Colors.black,
                ),
              ),
              Flexible(
                child: CategoriesListView(
                  onTap: (){

                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox.fromSize(
            size: const Size.fromHeight(64.0,),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ProductsSearchTextField(
                productsListViewModel: productsListViewModel,
              ),
            ),
          ),
          Flexible(
            child: ProductsListView(
              productsListViewModel: productsListViewModel,
            ),
          ),
        ],
      ),
    );
  }
}

