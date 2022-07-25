import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart' as provider;
import 'package:untitled04/app/app_route_names.dart';
import 'package:untitled04/app/app_router.dart';
import 'package:untitled04/data/repositories/categories/categories_repository.dart';
import 'package:untitled04/domain/dio_helper.dart';
import 'package:untitled04/domain/product/products_domain.dart';
import '../data/repositories/products/products_repository.dart';
import '../domain/categories/categories_domain.dart';

class MyApp extends StatelessWidget {
  const MyApp() : super(key: null,);

  @override
  Widget build(BuildContext context,) {
    return provider.MultiProvider(
      providers: [
        provider.Provider<Dio>(
          create: (buildContext,) => DioHelper.init(),
        ),
        provider.ProxyProvider<Dio, CategoriesDomain>(
          create: (buildContext,) => CategoriesFromApiDomain(
            dioHelper: provider.Provider.of<Dio>(buildContext, listen: false,),
          ),
          update: (buildContext, Dio dioHelper, _,) => CategoriesFromApiDomain(
            dioHelper: dioHelper,
          ),
        ),
        provider.ProxyProvider<CategoriesDomain, CategoriesRepository>(
          create: (buildContext,) => CategoriesRepository(
            categoriesDomain: provider.Provider.of<CategoriesDomain>(buildContext, listen: false,),
          ),
          update: (buildContext, CategoriesDomain categoriesDomain, _,) => CategoriesRepository(
            categoriesDomain: categoriesDomain,
          ),
        ),
        provider.ProxyProvider<Dio, ProductsDomain>(
          create: (buildContext,) => ProductsFromApiDomain(
            dioHelper: provider.Provider.of<Dio>(buildContext, listen: false,),
          ),
          update: (buildContext, Dio dioHelper, _,) => ProductsFromApiDomain(
            dioHelper: dioHelper,
          ),
        ),
        provider.ProxyProvider<ProductsDomain, ProductsRepository>(
          create: (buildContext,) => ProductsRepository(
            productsDomain: provider.Provider.of<ProductsDomain>(buildContext, listen: false,),
          ),
          update: (buildContext, ProductsDomain productsDomain, _,) => ProductsRepository(
            productsDomain: productsDomain,
          ),
        ),
      ],
      child: riverpod.ProviderScope(
        child: MaterialApp(
          title: 'Homework Task',
          builder: (BuildContext buildContext, Widget? child,) {
            return SafeArea(
              child: child!,
            );
          },
          initialRoute: AppRouteNames.homeScreenRoute,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
