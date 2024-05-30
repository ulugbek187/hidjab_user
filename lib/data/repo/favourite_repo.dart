import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidjab_user/data/models/product_model.dart';
import 'package:hidjab_user/utils/constans/app_constans.dart';
import '../response/network_response.dart';

class FavouriteRepo {
  Future<NetworkResponse> addToFavourites(ProductModel productModel) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.favourites)
          .where('user_id', isEqualTo: productModel.userId)
          .get();

      List<ProductModel> p = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      bool isExist = false;

      for (var element in p) {
        if (element.imageUrl == productModel.imageUrl) {
          isExist = true;
          break;
        }
      }
      if (!isExist) {
        DocumentReference documentReference = await FirebaseFirestore.instance
            .collection(AppConstants.favourites)
            .add(productModel.toJson());

        await FirebaseFirestore.instance
            .collection(AppConstants.favourites)
            .doc(documentReference.id)
            .update({'doc_id': documentReference.id});

        return NetworkResponse(
          data: 'success',
        );
      } else {
        return NetworkResponse(
          errorText: 'Product already exists!!!',
        );
      }
    } on FirebaseException catch (e) {
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }

  Stream<List<ProductModel>> listenFavourites(String userId) =>
      FirebaseFirestore.instance
          .collection(AppConstants.favourites)
          .where('user_id', isEqualTo: userId)
          .snapshots()
          .map(
            (e) => e.docs
                .map(
                  (ev) => ProductModel.fromJson(
                    ev.data(),
                  ),
                )
                .toList(),
          );

  Future<NetworkResponse> deleteFavourite(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.favourites)
          .doc(docId)
          .delete();

      return NetworkResponse(data: 'success');
    } on FirebaseException catch (e) {
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }
}
