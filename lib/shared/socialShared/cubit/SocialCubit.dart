import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/model/CreateUserModel.dart';
import 'package:firebase_app/screens/CallsScreen.dart';
import 'package:firebase_app/screens/SettingsScreen.dart';
import 'package:firebase_app/screens/CommunitesScreen.dart';
import 'package:firebase_app/screens/UpdatesScreens.dart';
import 'package:firebase_app/screens/UsersScreen.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/shared/socialShared/SocialStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super((SocialInitialState()));
  static SocialCubit get(context) => BlocProvider.of<SocialCubit>(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    UpdatesScreen(),
    CallsScreen(),
    CommunitiesScreen(),
    UsersScreen(),
    SettingsScreen()
  ];
  void changeButtomNavigationBar(int index) {
    currentIndex = index;
    emit(SocialChangeBottomNavigationBarState());
  }

  late CreateUserModel createUserModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      createUserModel = CreateUserModel.fromJson(value.data());
      log(value.toString());
      emit(SocialGetUserSuccessState());
    }).catchError((onError) {
      emit(SocialGetUserErrorState(onError.toString()));
    });
  }
}
