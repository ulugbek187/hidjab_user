import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidjab_user/data/models/category_model.dart';
import 'package:hidjab_user/data/response/network_response.dart';
import 'package:hidjab_user/utils/constans/app_constans.dart';

class CategoryRepo {
  Stream<List<CategoryModel>> listenAllCategoris() => FirebaseFirestore.instance
      .collection(AppConstants.categories)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (e) => CategoryModel.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );

  Future<NetworkResponse> getAllCategoris() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .get();

      List<CategoryModel> c = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      return NetworkResponse(
        data: c,
      );
    } on FirebaseException catch (e) {
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }
}
