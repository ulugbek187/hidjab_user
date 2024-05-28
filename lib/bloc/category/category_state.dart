import 'package:equatable/equatable.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/category_model.dart';

class CategoryState extends Equatable {
  final FormStatus formStatus;
  final String error;
  final String statusMessage;
  final List<CategoryModel> listenableCategories;
  final List<CategoryModel> categories;

  const CategoryState({
    required this.formStatus,
    required this.error,
    required this.listenableCategories,
    required this.statusMessage,
    required this.categories,
  });

  CategoryState copyWith({
    FormStatus? formStatus,
    String? error,
    String? statusMessage,
    List<CategoryModel>? listenableCategories,
    List<CategoryModel>? categories,
  }) =>
      CategoryState(
        formStatus: formStatus ?? this.formStatus,
        error: error ?? this.error,
        listenableCategories: listenableCategories ?? this.listenableCategories,
        statusMessage: statusMessage ?? this.statusMessage,
        categories: categories ?? this.categories,
      );

  @override
  List<Object?> get props => [
        formStatus,
        error,
        statusMessage,
        listenableCategories,
        categories,
      ];

  static CategoryState initial() => const CategoryState(
        formStatus: FormStatus.pure,
        error: '',
        listenableCategories: [],
        categories: [],
        statusMessage: '',
      );
}
