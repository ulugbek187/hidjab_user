import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/user_model.dart';
import 'package:hidjab_user/data/repo/auth_repository.dart';
import 'package:hidjab_user/data/repo/storage_repository.dart';
import 'package:hidjab_user/data/repo/user_repo.dart';
import 'package:hidjab_user/data/response/network_response.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.authRepository,
    required this.userRepo,
  }) : super(AuthState.init()) {
    on<CheckAuthenticationEvent>(_checkAuthentication);
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_registerUser);
    on<SignInWithGoogleEvent>(_googleSignIn);
    on<LogOutUserEvent>(_logOutUser);
  }

  final AuthRepository authRepository;
  final UserRepo userRepo;

  _checkAuthentication(CheckAuthenticationEvent event, emit) async {
    User? user = FirebaseAuth.instance.currentUser;

    debugPrint("CURRENT USER:$user");
    if (user == null) {
      emit(state.copyWith(status: FormsStatus.unauthenticated));
    } else {
      emit(state.copyWith(status: FormsStatus.authenticated));
    }
  }

  _loginUser(LoginUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
        await authRepository.logInWithEmailAndPassword(
      email: "${event.phoneNumber}@gmail.com",
      password: event.password,
    );
    if (networkResponse.errorText.isEmpty) {
      String? myToken = await FirebaseMessaging.instance.getToken();
      StorageRepository.setString(key: "fc_token", value: myToken ?? "");
      UserCredential userCredential = networkResponse.data as UserCredential;

      UserModel userModel =
          state.userModel.copyWith(authUid: userCredential.user!.uid);

      emit(state.copyWith(
          status: FormsStatus.authenticated, userModel: userModel));
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _registerUser(RegisterUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
        await authRepository.registerWithEmailAndPassword(
      email: "${event.userModel.phoneNumber}@gmail.com",
      password: event.userModel.password,
    );
    if (networkResponse.errorText.isEmpty) {
      String? myToken = await FirebaseMessaging.instance.getToken();
      debugPrint("MyToken: $myToken  -------");
      StorageRepository.setString(key: "fc_token", value: myToken ?? "");
      UserCredential userCredential = networkResponse.data as UserCredential;
      UserModel userModel =
          event.userModel.copyWith(authUid: userCredential.user!.uid);
      emit(
        state.copyWith(
          status: FormsStatus.authenticated,
          statusMessage: "registered",
          userModel: userModel,
        ),
      );
    } else {
      // debugPrint("ERROR REGISTER USER!!! ${networkResponse.errorCode}");
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _googleSignIn(SignInWithGoogleEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse = await authRepository.googleSignIn();
    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data;
      UserModel userModel = UserModel(
        authUid: userCredential.user!.uid,
        phoneNumber: userCredential.user!.phoneNumber ?? "",
        userId: "",
        username: userCredential.user!.displayName ?? "",
        password: '',
        imageUrl: FirebaseAuth.instance.currentUser!.photoURL ?? '',
      );
      emit(
        state.copyWith(
          statusMessage: "registered",
          status: FormsStatus.authenticated,
          userModel: userModel,
        ),
      );

      userRepo.addUser(
        userModel,
      );
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _logOutUser(LogOutUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    await authRepository.logOutUser();
    emit(state.copyWith(status: FormsStatus.unauthenticated));
  }
}
