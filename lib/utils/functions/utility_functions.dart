import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidjab_user/data/models/basket_model.dart';
import 'package:hidjab_user/data/models/product_model.dart';
import '../colors/app_colors.dart';

SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
  statusBarColor: AppColors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
);

currentCategory(String categoryName) {
  if (categoryName.toLowerCase() == 'gadgets') {
    return [
      'Tablets',
      'Phones',
      'iPod',
      'iPads',
      'Laptops',
    ];
  }
  if (categoryName.toLowerCase() == 'kiyim') {
    return [
      'Shoes',
      'T-Shirt',
      'suit',
      'Jeans',
    ];
  }
  if (categoryName.toLowerCase() == 'acses') {
    return [
      'AirPods',
      'HeadPhones',
      'PowerBank',
      'Radio',
    ];
  }
  if (categoryName.toLowerCase() == 'electronics') {
    return [
      'refrigerator',
      'Vacuum cleaner',
      'Oven',
      'Micro wave',
    ];
  }
  return [];
}

String catName(String ctnm) {
  if (ctnm == 'Gadgets') {
    return 'gadgets';
  }
  if (ctnm == 'Clocthes') {
    return 'kiyim';
  }
  if (ctnm == 'Accessory') {
    return 'acses';
  }
  return '';
}

List<ProductModel> getProductsByCategory(
    List<ProductModel> allProducts, String globalCategoryName) {
  List<ProductModel> categoryProducts = [];
  for (var element in allProducts) {
    if (element.categoryId == globalCategoryName.toLowerCase()) {
      categoryProducts.add(element);
    }
  }

  return categoryProducts;
}

List<ProductModel> getRecommendedProducts(List<ProductModel> products) {
  List<ProductModel> recommendedProducts = [];
  for (var element in products) {
    if (int.parse(element.rate) >= 4.5) {
      recommendedProducts.add(element);
    }
  }
  return recommendedProducts;
}

double calculateAllPrice(List<BasketModel> baskets) {
  double summa = 0;
  for (var element in baskets) {
    summa += element.allPrice;
  }
  return summa;
}

List<String> splitImages(String input) {
  List<String> images = input.split(' ');
  for (var element in images) {
    debugPrint("$element asdfhas");
  }
  return images;
}

String formatDateWithSlash(String input) {
  if (input.length != 4) {}

  DateTime now = DateTime.now();
  int currentYear = now.year;
  int currentMonth = now.month;

  int year = int.parse(input.substring(0, 2));
  int month = int.parse(input.substring(2, 4));

  if (year > currentYear || (year == currentYear && month > currentMonth)) {}
  return '$year/$month';
}
