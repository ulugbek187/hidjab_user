import 'package:equatable/equatable.dart';

sealed class NabiEvent extends Equatable {
  const NabiEvent();
}

class GetCategoryProductsEvent extends NabiEvent {
  final List<String> categories;

  const GetCategoryProductsEvent({
    required this.categories,
  });

  @override
  List<Object?> get props => [
        categories,
      ];
}
