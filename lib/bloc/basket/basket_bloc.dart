import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidjab_user/bloc/basket/basket_event.dart';
import 'package:hidjab_user/bloc/basket/basket_state.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/basket_model.dart';
import 'package:hidjab_user/data/repo/basket_repo.dart';
import 'package:hidjab_user/data/response/network_response.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc(this.basketRepo) : super(BasketState.initial()) {
    on<AddToBasketEvent>(_addToBasket);
    on<UpdateBasketEvent>(_updateBasket);
    on<DeleteBasketEvent>(_deleteBasket);
    on<ListenBasketEvent>(_listenAllBaskets);
    on<GetBasketEvent>(_getBaskets);
  }

  BasketRepo basketRepo;

  _addToBasket(AddToBasketEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormsStatus.loading,
      ),
    );
    NetworkResponse networkResponse = await basketRepo.addToBasket(
      event.basketModel,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormsStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormsStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }

  _getBaskets(GetBasketEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormsStatus.loading,
      ),
    );
    NetworkResponse networkResponse = await basketRepo.getBaskets(
      event.userId,
    );

    if (networkResponse.errorText.isEmpty) {
      List<BasketModel> baskets = networkResponse.data;
      emit(
        state.copyWith(
          formStatus: FormsStatus.success,
          baskets: baskets,
        ),
      );
    }
  }

  _updateBasket(UpdateBasketEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormsStatus.loading,
      ),
    );
    NetworkResponse networkResponse = await basketRepo.updateCard(
      event.basketModel,
    );
    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormsStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormsStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }

  _deleteBasket(DeleteBasketEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormsStatus.loading,
      ),
    );
    NetworkResponse networkResponse = await basketRepo.deleteCard(
      event.uuid,
    );
    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormsStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormsStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }

  Future<void> _listenAllBaskets(
      ListenBasketEvent event, Emitter<BasketState> emit) async {
    try {
      await for (final baskets in basketRepo.getAllBasket(event.userId)) {
        if (!emit.isDone) {
          emit(
            state.copyWith(
              formStatus: FormsStatus.success,
              baskets: baskets,
            ),
          );
        }
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            formStatus: FormsStatus.error,
            errorText: e.toString(),
          ),
        );
      }
    }
  }
}
