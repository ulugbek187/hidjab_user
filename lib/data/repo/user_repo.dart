import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidjab_user/data/models/user_model.dart';
import 'package:hidjab_user/data/response/network_response.dart';
import 'package:hidjab_user/utils/constans/app_constans.dart';

class UserRepo {
  Future<NetworkResponse> addUser(UserModel userModel) async {
    try {
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .add(userModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .doc(documentReference.id)
          .update(
        {"userId": documentReference.id},
      );

      return NetworkResponse(data: documentReference);
    } on FirebaseException catch (e) {
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }

  Future<NetworkResponse> getUser(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .where("authUid", isEqualTo: userId)
          .get();

      List<UserModel> users = querySnapshot.docs
          .map(
            (e) => UserModel.fromJson(
              e.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      return NetworkResponse(
        data: users.isEmpty ? UserModel.initial() : users[0],
      );
    } on FirebaseException catch (e) {
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }
}
