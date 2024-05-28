import 'package:flutter/cupertino.dart';
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
    on<GetCategoryEvent>(_getCategory);
    on<GetCategoryProductsEvent>(_getCategoryProducts);
  }

  final ProductRepo productRepo;

  _getCategory(GetCategoryEvent event, emit) {
    emit(
      state.copyWith(
        categories: event.categories,
      ),
    );
  }

  _getCategoryProducts(GetCategoryProductsEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    NetworkResponse networkResponse = NetworkResponse();


    List<List<ProductModel>> pr = await func(state, networkResponse, productRepo);


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
          formStatus: FormStatus.error,
          errorText: 'networkResponse.errorText',
        ),
      );
    }
  }
}


Future<List<List<ProductModel>>> func(NabiState state, NetworkResponse networkResponse, ProductRepo
productRepo) async {

  List<List<ProductModel>> pr = [];
  for (int i = 0; i < state.categories.length; i++) {
    networkResponse = await productRepo.getCategoryProducts(
      state.categories[i].docId,
    );


    debugPrint("ERROR----------------${networkResponse.errorText} LENGTH:-----------${networkResponse.data.runtimeType}");



    if (networkResponse.errorText.isEmpty) {
      pr.add(
        networkResponse.data,
      );
    }
  }

  return pr;
}