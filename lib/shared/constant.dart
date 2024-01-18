import 'package:flutter/material.dart';

TextEditingController email = TextEditingController();
TextEditingController passwaord = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey();
const kMainColor = Color(0xff005457);
const kSecondryColor = Colors.white54;
const kLightGreenColor = Color(0xff018786);
const kBlackColor = Colors.black54;
const kWhiteColor = Colors.white;
const kgreyColor = Color.fromARGB(255, 207, 206, 206);
const kBlueColor = Colors.blue;
String myName = '';
const kCollectionName = 'Users';
const kMessageCollection = 'messages';
const kMessage = 'message';
const kName = 'name';
String kUserName = '';
const kEmail = 'email';
const kPassword = 'password';
const kPhone = 'phone';
const kId = 'id';
const kAt = 'at';
const kId2 = 'id';
const kAt2 = 'at';
const kIsEmailVerified = 'isEmailVerified';
bool isDarkk = false;
Widget? widget;

String uId = '';

TextEditingController loginScreenEmailController = TextEditingController();
TextEditingController loginScreenPasswordController = TextEditingController();
GlobalKey<FormState> loginFormKey = GlobalKey();
TextEditingController signUpScreenEmailController = TextEditingController();
TextEditingController signUpScreenUserNameController = TextEditingController();
TextEditingController signUpScreenPasswordController = TextEditingController();
TextEditingController signUpScreenPhoneController = TextEditingController();

TextEditingController signUpScreenConfirmPasswordController =
    TextEditingController();
GlobalKey<FormState> signUpFormKey = GlobalKey();
AutovalidateMode loginAutovalidateMode = AutovalidateMode.disabled;
AutovalidateMode signUpAutovalidateMode = AutovalidateMode.disabled;
