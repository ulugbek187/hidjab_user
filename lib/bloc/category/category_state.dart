import 'package:equatable/equatable.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/category_model.dart';

class CategoryState extends Equatable {
  final FormStatus formStatus;
  final String error;
  final String statusMessage;
  final List<CategoryModel> categories;

  const CategoryState({
    required this.formStatus,
    required this.error,
    required this.categories,
    required this.statusMessage,
  });

  CategoryState copyWith({
    FormStatus? formStatus,
    String? error,
    String? statusMessage,
    List<CategoryModel>? categories,
  }) =>
      CategoryState(
        formStatus: formStatus ?? this.formStatus,
        error: error ?? this.error,
        categories: categories ?? this.categories,
        statusMessage: statusMessage ?? this.statusMessage,
      );

  @override
  List<Object?> get props => [
        formStatus,
        error,
        statusMessage,
        categories,
      ];

  static CategoryState initial() => const CategoryState(
        formStatus: FormStatus.pure,
        error: '',
        categories: [],
        statusMessage: '',
      );
}
