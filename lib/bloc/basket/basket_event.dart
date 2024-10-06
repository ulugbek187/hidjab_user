import 'package:equatable/equatable.dart';
import 'package:hidjab_user/data/models/basket_model.dart';

sealed class BasketEvent extends Equatable {
  const BasketEvent();
}

class AddToBasketEvent extends BasketEvent {
  final BasketModel basketModel;

  const AddToBasketEvent({
    required this.basketModel,
  });

  @override
  List<Object?> get props => [
        basketModel,
      ];
}

class UpdateBasketEvent extends BasketEvent {
  final BasketModel basketModel;

  const UpdateBasketEvent({
    required this.basketModel,
  });

  @override
  List<Object?> get props => [
        basketModel,
      ];
}

class ListenBasketEvent extends BasketEvent {
  @override
  List<Object?> get props => [];
}

class GetBasketEvent extends BasketEvent {
  @override
  List<Object?> get props => [];
}

class DeleteBasketEvent extends BasketEvent {
  final String uuid;

  const DeleteBasketEvent({
    required this.uuid,
  });

  @override
  List<Object?> get props => [
        uuid,
      ];
}
