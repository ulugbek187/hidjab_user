import 'package:equatable/equatable.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/product_model.dart';

final class ProductState extends Equatable {
  final List<ProductModel> products;
  final List<ProductModel> categoryProducts;

  final List<ProductModel> recommendedProducts;

  final FormsStatus formStatus;
  final String errorText;
  final String statusMessage;

  const ProductState(
      {required this.formStatus,
      required this.statusMessage,
      required this.errorText,
      required this.products,
      required this.recommendedProducts,
      required this.categoryProducts});

  ProductState copyWith({
    String? errorText,
    String? statusMessage,
    FormsStatus? formStatus,
    List<ProductModel>? products,
    List<ProductModel>? categoryProducts,
    List<ProductModel>? recommendedProducts,
  }) =>
      ProductState(
        formStatus: formStatus ?? this.formStatus,
        categoryProducts: categoryProducts ?? this.categoryProducts,
        statusMessage: statusMessage ?? this.statusMessage,
        errorText: errorText ?? this.errorText,
        products: products ?? this.products,
        recommendedProducts: recommendedProducts ?? this.recommendedProducts,
      );

  static ProductState initial() => const ProductState(
        formStatus: FormsStatus.pure,
        statusMessage: '',
        errorText: '',
        products: [],
        recommendedProducts: [],
        categoryProducts: [],
      );

  @override
  List<Object> get props => [
        products,
        formStatus,
        errorText,
        statusMessage,
        categoryProducts,
      ];
}
