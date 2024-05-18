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
    on<GetProductsByCategoryName>(
      _listenProductsByCategoryName,
    );
    on<GetProductsByModelName>(
      _listenProductsByModelName,
    );
    on<GetRecommendedProductsEvent>(
      _getRecommendedProducts,
    );
    on<GetByCategoryNameProductsEvent>(
      _getCategoryProducts,
    );
    on<SearchProductEvent>(
      _search,
    );
  }

  ProductRepo productRepo;

  _search(SearchProductEvent event, emit) {
    if (event.input.isEmpty) {
      emit(state.copyWith(products: state.products));
    } else {
      emit(state.copyWith(
        products: state.products.where(
          (element) {
            return element.productName.toLowerCase()
                .contains(event.input.toLowerCase());

          },
        ).toList(),
      ));
      return false;
    }
  }

  _getCategoryProducts(GetByCategoryNameProductsEvent event, emit) async {
    emit(state.copyWith(
      formStatus: FormStatus.loading,
    ));

    NetworkResponse gadgetsRes = await productRepo.getGadgetsCategory();

    if (gadgetsRes.errorText.isEmpty) {
      emit(state.copyWith(
        gadgets: gadgetsRes.data,
      ));
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorText: gadgetsRes.errorText.toString(),
      ));
    }

    NetworkResponse kiyimRes = await productRepo.getKiyimCategory();

    if (kiyimRes.errorText.isEmpty) {
      emit(state.copyWith(
        kiyim: kiyimRes.data,
      ));
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorText: kiyimRes.errorText,
      ));
    }

    NetworkResponse acsesRes = await productRepo.getAcsesCategory();

    if (acsesRes.errorText.isEmpty) {
      emit(state.copyWith(
        acses: acsesRes.data,
      ));
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorText: acsesRes.errorText,
      ));
    }
  }

  _getRecommendedProducts(GetRecommendedProductsEvent event, emit) async {
    NetworkResponse networkResponse =
        await productRepo.getRecommendedProducts();

    if (networkResponse.errorText.isEmpty) {
      List<ProductModel> recommendedProducts = [];
      List<ProductModel> products = networkResponse.data;

      for (var element in products) {
        if (element.rate > 4.5) {
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
      productRepo.getAllProducts(),
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

  _listenProductsByCategoryName(
    GetProductsByCategoryName event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );
    await emit.onEach(
      productRepo.getProductsByCategoryName(
        event.categoryName,
      ),
      onData: (
        List<ProductModel> products,
      ) {
        emit(
          state.copyWith(products: products, formStatus: FormStatus.success),
        );
      },
    );
  }

  _listenProductsByModelName(
    GetProductsByModelName event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );
    await emit.onEach(
      productRepo.getProductsByModelName(
        event.modelName,
      ),
      onData: (
        List<ProductModel> products,
      ) {
        emit(
          state.copyWith(products: products, formStatus: FormStatus.success),
        );
      },
    );
  }
}
