import 'package:equatable/equatable.dart';
import 'package:hidjab_user/data/models/category_model.dart';

sealed class NabiEvent extends Equatable {
  const NabiEvent();
}

class GetCategoryEvent extends NabiEvent {
  final List<CategoryModel> categories;

  const GetCategoryEvent({
    required this.categories,
  });

  @override
  List<Object?> get props => [
        categories,
      ];
}

class GetCategoryProductsEvent extends NabiEvent {
  const GetCategoryProductsEvent();

  @override
  List<Object?> get props => [];
}
