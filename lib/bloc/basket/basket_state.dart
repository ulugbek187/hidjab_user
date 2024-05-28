import 'package:equatable/equatable.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';

import '../../data/models/basket_model.dart';

class BasketState extends Equatable {
  const BasketState({
    required this.formStatus,
    required this.errorText,
    required this.baskets,
    required this.statusText,
  });

  final FormsStatus formStatus;
  final List<BasketModel> baskets;
  final String errorText;
  final String statusText;

  BasketState copyWith({
    FormsStatus? formStatus,
    List<BasketModel>? baskets,
    String? errorText,
    String? statusText,
  }) =>
      BasketState(
        formStatus: formStatus ?? this.formStatus,
        errorText: errorText ?? this.errorText,
        baskets: baskets ?? this.baskets,
        statusText: statusText ?? this.statusText,
      );

  static BasketState initial() => const BasketState(
        formStatus: FormsStatus.pure,
        errorText: '',
        baskets: [],
        statusText: '',
      );

  @override
  List<Object?> get props => [
        formStatus,
        errorText,
        baskets,
        statusText,
      ];
}
