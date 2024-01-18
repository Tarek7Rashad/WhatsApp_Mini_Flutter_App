import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/model/CreateUserModel.dart';

class UserRepository {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Stream<List<CreateUserModel>> getUsersStream() {
    return users.snapshots().map((QuerySnapshot querySnapshot) {
      List<CreateUserModel> usersList = [];
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        usersList
            .add(CreateUserModel.fromJson(doc.data() as Map<String, dynamic>?));
      }
      return usersList;
    });
  }
}
