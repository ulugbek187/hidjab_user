import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/user_model.dart';
import 'package:hidjab_user/data/repo/user_repo.dart';
import 'package:hidjab_user/data/response/network_response.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
    this.userRepo,
  ) : super(
          UserState.initial(),
        ) {
    on<AddUserEvent>(_addUser);
    on<GetUserEvent>(_getUser);
  }

  final UserRepo userRepo;

  _getUser(GetUserEvent event, emit) async {
    emit(
      state.copyWith(
        formsStatus: FormsStatus.loading,
      ),
    );

    NetworkResponse networkResponse = await userRepo.getUser(
      event.userId,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.success,
          userModel: networkResponse.data,
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

  _addUser(AddUserEvent event, emit) async {
    emit(
      state.copyWith(
        formsStatus: FormsStatus.loading,
      ),
    );

    NetworkResponse networkResponse = await userRepo.addUser(
      event.userModel,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.success,
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
}
