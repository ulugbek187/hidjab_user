import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidjab_user/data/models/product_model.dart';
import 'package:hidjab_user/utils/constans/app_constans.dart';
import '../response/network_response.dart';

class ProductRepo {
  Stream<List<ProductModel>> listenAllProducts() => FirebaseFirestore.instance
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

  // Future<NetworkResponse> getCtgPr(){
  //
  //   try{
  //
  //     FirebaseFirestore.instance.collection(AppConstants.products).get();
  //
  //
  //
  //
  //   }catch(e){
  //
  //   }
  //
  //
  //
  //
  //
  //
  // }

  Stream<List<ProductModel>> listenProductsByCategoryId(String categoryiD) =>
      FirebaseFirestore.instance
          .collection(AppConstants.products)
          .where(
            "category_id",
            isEqualTo: categoryiD,
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
