import 'package:flutter/material.dart';
import 'package:flutter_app/data/models/order_categories_model.dart';
import 'package:flutter_app/presentation/screens/orders_screen/views/orders_screen_view.dart';
import 'package:flutter_app/presentation/screens/sub_orders_screen/views/sub_orders_screen_view.dart';
import 'app_route_names.dart';

class AppRouter{
  static Route? onGenerateRoute(RouteSettings routeSettings,){
    switch (routeSettings.name){
      case AppRouteNames.ordersScreenRoute:
        return _routeTo(
          () => const OrdersScreenView(),
        );
      case AppRouteNames.subOrdersScreenRoute:
        return _routeTo(
          () => SubOrdersScreenView((routeSettings.arguments as OrdersCategory),),
        );
    }
  }

  static Route? _routeTo(Widget Function() builderFunction,){
    return MaterialPageRoute(
      builder: (_,) => SafeArea(child: builderFunction(),),
    );
  }
}