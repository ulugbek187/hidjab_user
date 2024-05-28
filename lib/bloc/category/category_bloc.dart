import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidjab_user/bloc/category/category_event.dart';
import 'package:hidjab_user/bloc/category/category_state.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/category_model.dart';
import 'package:hidjab_user/data/repo/category_repo.dart';
import 'package:hidjab_user/data/response/network_response.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(this.categoryRepo) : super(CategoryState.initial()) {
    on<ListenAllCategoriesEvent>(_listenAllCategories);
    on<GetCategories>(_getCategories);
  }

  CategoryRepo categoryRepo;

  _getCategories(GetCategories event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    NetworkResponse networkResponse = await categoryRepo.getAllCategoris();

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          categories: networkResponse.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          error: networkResponse.errorText,
        ),
      );
    }
  }

  _listenAllCategories(ListenAllCategoriesEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    await emit.onEach(categoryRepo.listenAllCategoris(),
        onData: (List<CategoryModel> ctg) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          listenableCategories: ctg,
        ),
      );
    }, onError: (e, s) {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          error: e.toString(),
        ),
      );
    });
  }
}
