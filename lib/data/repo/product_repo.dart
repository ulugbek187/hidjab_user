import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidjab_user/data/models/product_model.dart';
import 'package:hidjab_user/utils/constans/app_constans.dart';

import '../response/network_response.dart';

class ProductRepo {
  Stream<List<ProductModel>> getAllProducts() => FirebaseFirestore.instance
      .collection(AppConstants.products)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (e) => ProductModel.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );

  Future<NetworkResponse> getRecommendedProducts() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .get();

      List<ProductModel> products = querySnapshot.docs
          .map(
            (e) => ProductModel.fromJson(
              e.data() as Map<String, dynamic>,
            ),
          )
          .toList();
      return NetworkResponse(
        data: products,
      );
    } on FirebaseException catch (error) {
      return NetworkResponse(
        errorCode: error.code,
        errorText: error.message ?? '',
      );
    }
  }

  Future<NetworkResponse> getGadgetsCategory() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .where('global_category', isEqualTo: 'gadgets')
          .get();

      List<ProductModel> products = querySnapshot.docs
          .map(
            (e) => ProductModel.fromJson(
              e.data() as Map<String, dynamic>,
            ),
          )
          .toList();
      return NetworkResponse(
        data: products,
      );
    } on FirebaseException catch (error) {
      return NetworkResponse(
        errorCode: error.code,
        errorText: error.message ?? '',
      );
    }
  }

  Future<NetworkResponse> getKiyimCategory() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .where('global_category', isEqualTo: 'kiyim')
          .get();

      List<ProductModel> products = querySnapshot.docs
          .map(
            (e) => ProductModel.fromJson(
              e.data() as Map<String, dynamic>,
            ),
          )
          .toList();
      return NetworkResponse(
        data: products,
      );
    } on FirebaseException catch (error) {
      return NetworkResponse(
        errorCode: error.code,
        errorText: error.message ?? '',
      );
    }
  }

  Future<NetworkResponse> getAcsesCategory() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .where('global_category', isEqualTo: 'acses')
          .get();

      List<ProductModel> products = querySnapshot.docs
          .map(
            (e) => ProductModel.fromJson(
              e.data() as Map<String, dynamic>,
            ),
          )
          .toList();
      return NetworkResponse(
        data: products,
      );
    } on FirebaseException catch (error) {
      return NetworkResponse(
        errorCode: error.code,
        errorText: error.message ?? '',
      );
    }
  }

  Stream<List<ProductModel>> getProductsByCategoryName(String categoryName) =>
      FirebaseFirestore.instance
          .collection(AppConstants.products)
          .where(
            "category_name",
            isEqualTo: categoryName,
          )
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (e) => ProductModel.fromJson(
                    e.data(),
                  ),
                )
                .toList(),
          );

  Stream<List<ProductModel>> getProductsByModelName(String modelName) =>
      FirebaseFirestore.instance
          .collection(AppConstants.products)
          .where(
            "model_name",
            isEqualTo: modelName,
          )
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (e) => ProductModel.fromJson(
                    e.data(),
                  ),
                )
                .toList(),
          );
}
