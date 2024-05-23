import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/product_model.dart';
import 'package:hidjab_user/data/repo/product_repo.dart';
import 'package:hidjab_user/data/response/network_response.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(
    this.productRepo,
  ) : super(
          ProductState.initial(),
        ) {
    on<GetProductsEvent>(
      _listenAllProducts,
    );
    on<GetProductsByCategoryId>(
      _listenProductsCategoryId,
    );

    on<GetRecommendedProductsEvent>(
      _getRecommendedProducts,
    );

    on<SearchProductEvent>(
      _search,
    );
  }

  ProductRepo productRepo;

  _listenProductsCategoryId(GetProductsByCategoryId event, Emitter emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    await emit.onEach(
      productRepo.listenProductsByCategoryId(event.categoryDocId),
      onData: (List<ProductModel> ctgPr) {
        emit(
          state.copyWith(
            formStatus: FormStatus.success,
            categoryProducts: ctgPr,
          ),
        );
      },
      onError: (error, stackTrace) {
        emit(
          state.copyWith(
            formStatus: FormStatus.error,
            errorText: error.toString(),
          ),
        );
      },
    );
  }

  _search(SearchProductEvent event, emit) {
    if (event.input.isEmpty) {
      emit(state.copyWith(products: state.products));
    } else {
      emit(state.copyWith(
        products: state.products.where(
          (element) {
            return element.productName
                .toLowerCase()
                .contains(event.input.toLowerCase());
          },
        ).toList(),
      ));
      return false;
    }
  }

  _getRecommendedProducts(GetRecommendedProductsEvent event, emit) async {
    NetworkResponse networkResponse =
        await productRepo.getRecommendedProducts();

    if (networkResponse.errorText.isEmpty) {
      List<ProductModel> recommendedProducts = [];
      List<ProductModel> products = networkResponse.data;

      for (var element in products) {
        if (int.parse(element.rate) > 4.5) {
          recommendedProducts.add(element);
        }
      }

      emit(
        state.copyWith(
          recommendedProducts: recommendedProducts,
        ),
      );
    }
  }

  _listenAllProducts(
    GetProductsEvent event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    await emit.onEach(
      productRepo.listenAllProducts(),
      onData: (
        List<ProductModel> allProducts,
      ) {
        emit(
          state.copyWith(
            products: allProducts,
            formStatus: FormStatus.success,
          ),
        );
      },
    );
  }
}
