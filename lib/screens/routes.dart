import 'package:flutter/material.dart';
import 'package:hidjab_user/screens/category_screen/category_screen.dart';
import 'package:hidjab_user/screens/splash_screen/splash_screen.dart';

import '../data/models/product_model.dart';
import 'basket/basket_screen.dart';
import 'detail_screen/detail_screen.dart';
import 'global_screen/global_screen.dart';

class AppRoutes {
  static Route generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(
          const SplashScreen(),
        );
      case RouteNames.homeScreen:
        return navigate(
          const HomeScreen(),
        );
      case RouteNames.categoryScreen:
        return navigate(
           CategoryScreen(
            category: settings.arguments as String,
          ),
        );

      case RouteNames.basketScreen:
        return navigate(
          const BasketScreen(),
        );
      case RouteNames.productDetailScreen:
        return navigate(
           ProductDetailsScreen(productModel: settings.arguments as ProductModel),
        );

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text(
                "This kind of rout does not exist!",
              ),
            ),
          ),
        );
    }
  }

  static navigate(
    Widget widget,
  ) {
    return MaterialPageRoute(
      builder: (
        context,
      ) =>
          widget,
    );
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String homeScreen = "/home_screen";
  static const String categoryScreen = "/category_screen";
  static const String basketScreen = "/basket_screen";
  static const String productDetailScreen = "/product_detail_screen";
}