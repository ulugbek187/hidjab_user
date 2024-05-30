import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/product_model.dart';
import 'package:hidjab_user/data/repo/favourite_repo.dart';
import 'package:hidjab_user/data/response/network_response.dart';

part 'favourite_event.dart';

part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc(this.favouriteRepo) : super(FavouriteState.initial()) {
    on<AddToFavouritesEvent>(_addToFavourites);
    on<DeleteFromFavouritesEvent>(_deleteFromFavourites);
    on<ListenFavouritesEvent>(_listenFavourites);
    on<ChangeFavouriteInitialStateEvent>(_changeInitialState);
  }

  final FavouriteRepo favouriteRepo;

  _changeInitialState(ChangeFavouriteInitialStateEvent event, emit) {
    emit(
      state.copyWith(
        formsStatus: FormsStatus.pure,
        errorText: '',
        statusText: '',
        productModel: ProductModel.initial(),
      ),
    );
  }

  _addToFavourites(AddToFavouritesEvent event, emit) async {
    emit(
      state.copyWith(
        formsStatus: FormsStatus.loading,
      ),
    );

    NetworkResponse networkResponse = await favouriteRepo.addToFavourites(
      event.productModel,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.success,
          statusText: networkResponse.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }

  _deleteFromFavourites(DeleteFromFavouritesEvent event, emit) async {
    emit(
      state.copyWith(
        formsStatus: FormsStatus.loading,
      ),
    );

    NetworkResponse networkResponse =
        await favouriteRepo.deleteFavourite(event.docId);

    if (networkResponse.errorText.isEmpty) {
      state.copyWith(
        formsStatus: FormsStatus.success,
        statusText: networkResponse.data,
      );
    } else {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }

  _listenFavourites(ListenFavouritesEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        formsStatus: FormsStatus.loading,
      ),
    );

    await emit.onEach(favouriteRepo.listenFavourites(event.userId),
        onData: (List<ProductModel> pr) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.success,
          allFavourites: pr,
        ),
      );
    }, onError: (e, s) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.error,
          errorText: e.toString(),
        ),
      );
    });
  }
}
