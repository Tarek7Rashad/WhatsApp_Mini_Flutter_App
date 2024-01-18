// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/model/CreateUserModel.dart';
import 'package:firebase_app/screens/CallsScreen.dart';
import 'package:firebase_app/screens/CommunitesScreen.dart';
import 'package:firebase_app/screens/UpdatesScreens.dart';
import 'package:firebase_app/screens/UsersScreen.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/SettingsScreen.dart';

part 'LoginAndRegisterStates.dart';

@immutable
class LoginAndRegisterCubit extends Cubit<LoginAndRegisterStates> {
  LoginAndRegisterCubit() : super(SocialCubitInitial());
  static LoginAndRegisterCubit get(context) => BlocProvider.of(context);
  int currentIndex = 3;
  List<String> titles = ['Updates', 'Calls', 'Communites', 'Chats', 'Settings'];

  void changeButtomNavigationBar(int index) {
    currentIndex = index;
    emit(SocialChangeBottomNavigationBarState());
  }

  List<Widget> screens = const [
    UpdatesScreen(),
    CallsScreen(),
    CommunitiesScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  bool isLoading = false;
  bool loginIsLoading = false;
  bool logOutIsLoading = false;
  bool passwordIsVisible = true;
  IconData suffix = Icons.visibility_outlined;
  bool isDark = isDarkk;
  void changeMode() {
    emit(AppChangeModeState());
    isDarkk = !isDarkk;
  }

  void changePassword() {
    passwordIsVisible = !passwordIsVisible;
    passwordIsVisible
        ? suffix = Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibility());
  }

  late String email;
  late String password;
  Future<void> signIn({required String email, required String password}) async {
    emit(SocialLoginLoadingState());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    emit(SocialLoginSuccessState(email));
    //     .then((value) {
    //   log(email.toString());
    //   emit(SocialLoginSuccessState(value.user!.uid));
    // }).catchError((error) {
    //   emit(SocialLoginFailureState(error.toString()));
    // });
  }

  late String signUpEmail;
  late String signUpPassword;
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      emit(SocialSignUpLoadingState());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then(
        (value) {
          userCreate(
            name: name,
            email: email,
            // password: password,
            phone: phone,
            id: value.user!.uid,
          );
          emit(SocialSignUpSuccessState());
        },
      ).catchError((error) {
        emit(SocialSignUpFailureState(error.toString()));
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      log("sign out");
    }).catchError((error) {
      log("'Sign Out Error', $error");
    });
    emit(SignOutState());
  }

  void userCreate({
    required String name,
    required String email,
    // required String password,
    required String phone,
    required String id,
  }) {
    CreateUserModel userModel = CreateUserModel(
        name: name, email: email, phone: phone, id: id, isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .set(userModel.userMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      log('Error During User Creation : $onError');
      emit(CreateUserErrorState(onError.toString()));
    });
  }
}
