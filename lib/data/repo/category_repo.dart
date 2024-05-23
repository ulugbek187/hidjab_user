import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidjab_user/data/models/category_model.dart';
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
}
