part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

class AddUserEvent extends UserEvent {
  final UserModel userModel;

  const AddUserEvent({
    required this.userModel,
  });

  @override
  List<Object?> get props => [
        userModel,
      ];
}
