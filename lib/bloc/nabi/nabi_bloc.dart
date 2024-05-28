import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidjab_user/bloc/nabi/nabi_event.dart';
import 'package:hidjab_user/bloc/nabi/nabi_state.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/product_model.dart';
import 'package:hidjab_user/data/repo/product_repo.dart';
import 'package:hidjab_user/data/response/network_response.dart';

class NabiBloc extends Bloc<NabiEvent, NabiState> {
  NabiBloc(
    this.productRepo,
  ) : super(NabiState.initial()) {
    on<GetCategoryProductsEvent>(_getCategoryProducts);
  }

  final ProductRepo productRepo;

  _getCategoryProducts(GetCategoryProductsEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    List<List<ProductModel>> pr = [];

    for (int i = 0; i < event.categories.length; i++) {
      NetworkResponse networkResponse = await productRepo.getCategoryProducts(
        event.categories[i],
      );

      if (networkResponse.errorText.isEmpty) {
        pr.add(
          networkResponse.data,
        );
      }
    }

    if (pr.isNotEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          products: pr,
        ),
      );
    } else {
      emit(
        state.copyWith(
            formStatus: FormStatus.error, errorText: 'LIST IS EMPTY'),
      );
    }
  }
}
