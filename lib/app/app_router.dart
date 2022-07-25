import 'package:flutter/material.dart';
import 'package:untitled04/presentation/cart_screen/cart_screen_view.dart';
import 'package:untitled04/presentation/home_screen/home_screen_view.dart';
import 'app_route_names.dart';

class AppRouter{
  static Route? onGenerateRoute(RouteSettings routeSettings,){
    switch (routeSettings.name){
      case AppRouteNames.homeScreenRoute:
        return _routeTo(
          () => const HomeScreenView(),
        );
      case AppRouteNames.cartScreenRoute:
        return _routeTo(
          () => const CartScreenView(),
        );
      default:
        return null;
    }
  }

  static Route? _routeTo(Widget Function() widgetFunction,){
    return MaterialPageRoute(
      builder: (_,) => widgetFunction(),
    );
  }
}