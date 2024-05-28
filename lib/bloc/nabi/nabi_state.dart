import 'package:equatable/equatable.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import '../../data/models/product_model.dart';

class NabiState extends Equatable {
  final List<String> categories;
  final List<List<ProductModel>> products;
  final String errorText;
  final FormStatus formStatus;

  const NabiState({
    required this.products,
    required this.categories,
    required this.errorText,
    required this.formStatus,
  });

  NabiState copyWith({
    List<String>? categories,
    List<List<ProductModel>>? products,
    String? errorText,
    FormStatus? formStatus,
  }) =>
      NabiState(
        products: products ?? this.products,
        categories: categories ?? this.categories,
        errorText: errorText ?? this.errorText,
        formStatus: formStatus ?? this.formStatus,
      );

  static NabiState initial() => const NabiState(
        products: [],
        categories: [],
        errorText: '',
        formStatus: FormStatus.pure,
      );

  @override
  List<Object?> get props => [
        categories,
        products,
        errorText,
        formStatus,
      ];
}
