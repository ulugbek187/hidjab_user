part of 'user_bloc.dart';

class UserState extends Equatable {
  final UserModel userModel;
  final FormsStatus formsStatus;
  final String errorText;

  const UserState({
    required this.formsStatus,
    required this.userModel,
    required this.errorText,
  });

  static UserState initial() => UserState(
        formsStatus: FormsStatus.pure,
        userModel: UserModel.initial(),
        errorText: '',
      );

  UserState copyWith({
    UserModel? userModel,
    FormsStatus? formsStatus,
    String? errorText,
  }) =>
      UserState(
        formsStatus: formsStatus ?? this.formsStatus,
        userModel: userModel ?? this.userModel,
        errorText: errorText ?? this.errorText,
      );

  @override
  List<Object?> get props => [
        userModel,
        formsStatus,
        errorText,
      ];
}
