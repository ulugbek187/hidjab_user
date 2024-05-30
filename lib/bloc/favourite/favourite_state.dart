part of 'favourite_bloc.dart';

class FavouriteState extends Equatable {
  final List<ProductModel> allFavourites;
  final String errorText;
  final String statusText;
  final ProductModel productModel;
  final FormsStatus formsStatus;

  const FavouriteState({
    required this.formsStatus,
    required this.statusText,
    required this.allFavourites,
    required this.errorText,
    required this.productModel,
  });

  FavouriteState copyWith({
    List<ProductModel>? allFavourites,
    String? errorText,
    String? statusText,
    ProductModel? productModel,
    FormsStatus? formsStatus,
  }) =>
      FavouriteState(
        formsStatus: formsStatus ?? this.formsStatus,
        statusText: statusText ?? this.statusText,
        allFavourites: allFavourites ?? this.allFavourites,
        errorText: errorText ?? this.errorText,
        productModel: productModel ?? this.productModel,
      );

  static FavouriteState initial() => FavouriteState(
        formsStatus: FormsStatus.pure,
        statusText: '',
        allFavourites: const [],
        errorText: '',
        productModel: ProductModel.initial(),
      );

  @override
  List<Object?> get props => [
        errorText,
        allFavourites,
        statusText,
        formsStatus,
        productModel,
      ];
}
