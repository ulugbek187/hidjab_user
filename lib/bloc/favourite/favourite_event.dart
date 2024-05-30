part of 'favourite_bloc.dart';

sealed class FavouriteEvent extends Equatable {
  const FavouriteEvent();
}

class AddToFavouritesEvent extends FavouriteEvent {
  final ProductModel productModel;

  const AddToFavouritesEvent(
    this.productModel,
  );

  @override
  List<Object?> get props => [
        productModel,
      ];
}

class ChangeFavouriteInitialStateEvent extends FavouriteEvent {
  @override
  List<Object?> get props => [];
}

class DeleteFromFavouritesEvent extends FavouriteEvent {
  final String docId;

  const DeleteFromFavouritesEvent(this.docId);

  @override
  List<Object?> get props => [
        docId,
      ];
}

class ListenFavouritesEvent extends FavouriteEvent {
  final String userId;

  const ListenFavouritesEvent(this.userId);

  @override
  List<Object?> get props => [
        userId,
      ];
}
