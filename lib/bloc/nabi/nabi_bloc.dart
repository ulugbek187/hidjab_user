import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidjab_user/bloc/nabi/nabi_event.dart';
import 'package:hidjab_user/bloc/nabi/nabi_state.dart';

class NabiBloc extends Bloc<NabiEvent, NabiState> {
  NabiBloc() : super(NabiInitial()) {
    on<NabiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
