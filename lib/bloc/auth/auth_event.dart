part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckAuthenticationEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends AuthEvent {
  final String password;
  final String phoneNumber;

  LoginUserEvent({
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        password,
      ];
}

class RegisterUserEvent extends AuthEvent {
  final UserModel userModel;

  RegisterUserEvent({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class LogOutUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignInWithGoogleEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
