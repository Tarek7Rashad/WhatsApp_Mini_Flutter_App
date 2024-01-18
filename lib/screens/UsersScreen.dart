import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/model/CreateUserModel.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/shared/network/remote.dart';
import 'package:firebase_app/widget/CustomAppBar.dart';
import 'package:firebase_app/widget/CustomUsersListView.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  List<CreateUserModel> usersList = [];
  late CreateUserModel createUserModel;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: StreamBuilder<List<CreateUserModel>>(
          stream: UserRepository().getUsersStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              usersList = snapshot.data!;
              // log(usersList.length.toString());
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: height * .04,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.asset(
                    'assets/images/images-removebg-preview.png',
                    color: kBlueColor,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      log(usersList.length.toString());
                    },
                    icon: const Icon(Icons.camera_alt_outlined),
                    color: kBlueColor,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle,
                      color: kBlueColor,
                    ),
                    color: kBlueColor,
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    CustomAppBar(
                      width: width,
                      text: 'Chats',
                      icon: const Icon(Icons.more_vert_rounded),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Expanded(
                      child: CustomUsersListView(usersList: usersList,),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
