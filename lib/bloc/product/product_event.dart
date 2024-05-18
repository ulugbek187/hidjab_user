import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetByCategoryNameProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetRecommendedProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetProductsByCategoryName extends ProductEvent {
  final String categoryName;

  const GetProductsByCategoryName({
    required this.categoryName,
  });

  @override
  List<Object?> get props => [
        categoryName,
      ];
}

class GetProductsByModelName extends ProductEvent {
  final String modelName;

  const GetProductsByModelName({
    required this.modelName,
  });

  @override
  List<Object?> get props => [
        modelName,
      ];
}

class SearchProductEvent extends ProductEvent {
  final String input;

  const SearchProductEvent({required this.input});

  @override
  List<Object?> get props => [];
}
