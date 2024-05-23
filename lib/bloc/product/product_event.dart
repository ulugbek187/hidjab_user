import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetRecommendedProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetProductsByCategoryId extends ProductEvent {
  final String categoryDocId;

  const GetProductsByCategoryId({required this.categoryDocId});

  @override
  List<Object?> get props => [categoryDocId];
}


class SearchProductEvent extends ProductEvent {
  final String input;

  const SearchProductEvent({required this.input});

  @override
  List<Object?> get props => [];
}
