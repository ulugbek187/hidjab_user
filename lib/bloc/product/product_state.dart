import 'package:equatable/equatable.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/product_model.dart';

final class ProductState extends Equatable {
  final List<ProductModel> products;
  final List<ProductModel> gadgets;
  final List<ProductModel> acses;
  final List<ProductModel> kiyim;
  final List<ProductModel> recommendedProducts;

  final FormStatus formStatus;
  final String errorText;
  final String statusMessage;

  const ProductState({
    required this.formStatus,
    required this.statusMessage,
    required this.errorText,
    required this.products,
    required this.recommendedProducts,
    required this.gadgets,
    required this.acses,
    required this.kiyim,
  });

  ProductState copyWith({
    String? errorText,
    String? statusMessage,
    FormStatus? formStatus,
    List<ProductModel>? products,
    List<ProductModel>? gadgets,
    List<ProductModel>? acses,
    List<ProductModel>? kiyim,
    List<ProductModel>? recommendedProducts,
  }) =>
      ProductState(
        kiyim: kiyim ?? this.kiyim,
        formStatus: formStatus ?? this.formStatus,
        gadgets: gadgets ?? this.gadgets,
        statusMessage: statusMessage ?? this.statusMessage,
        errorText: errorText ?? this.errorText,
        products: products ?? this.products,
        recommendedProducts: recommendedProducts ?? this.recommendedProducts,
        acses: acses ?? this.acses,
      );

  static ProductState initial() => const ProductState(
        formStatus: FormStatus.pure,
        statusMessage: '',
        errorText: '',
        products: [],
        recommendedProducts: [],
        gadgets: [],
        acses: [],
        kiyim: [],
      );

  @override
  List<Object> get props => [
        products,
        formStatus,
        errorText,
        statusMessage,
        gadgets,
        kiyim,
        acses,
      ];
}
