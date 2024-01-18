import 'package:firebase_app/shared/constant.dart';

class CreateUserModel {
  String name;
  String email;
  // String password;
  String phone;
  String id;
  bool isEmailVerified;
  CreateUserModel(
      {required this.name,
      // required this.password,
      required this.email,
      required this.phone,
      required this.id,
      required this.isEmailVerified});
  factory CreateUserModel.fromJson(Map<String, dynamic>? jsonData) {
    return CreateUserModel(
        name: jsonData![kName] ?? '',
        email: jsonData[kEmail] ?? '',
        phone: jsonData[kPhone] ?? '',
        id: jsonData[kId] ?? '',
        isEmailVerified: jsonData[kIsEmailVerified] ?? false);
  }
  Map<String, dynamic> userMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'id': id,
      'isEmailVerified': isEmailVerified,
    };
  }
}
