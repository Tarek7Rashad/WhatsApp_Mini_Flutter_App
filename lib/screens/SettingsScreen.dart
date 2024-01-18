import 'dart:developer';

import 'package:firebase_app/model/CreateUserModel.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/shared/network/local.dart';
import 'package:firebase_app/shared/network/remote.dart';
import 'package:firebase_app/shared/socialShared/cubit/LoginAndRegisterCubit.dart';
import 'package:firebase_app/widget/CustomAppBar.dart';
import 'package:firebase_app/widget/CustomDivider.dart';
import 'package:firebase_app/widget/CustomRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

List<CreateUserModel> users = [];
String name = '';
List<CreateUserModel> usersLLL = [];

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<List<CreateUserModel>>(
        stream: UserRepository().getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            users = snapshot.data!;
            for (var i = 0; i < users.length; i++) {
              if (users[i].email == uId) {
                name = users[i].name;
              
              }
              // else if (users[i].email == loginScreenEmailController.text) {
              //   uId = loginScreenEmailController.text;
              //   name = users[i].name;
              // }
            }
          }
          return BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = BlocProvider.of<LoginAndRegisterCubit>(context);
              return Scaffold(
                  body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * .04,
                      ),
                      CustomAppBar(width: width, text: 'Settings'),
                      SizedBox(
                        height: height * .001,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: height * .02,
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: kWhiteColor.withOpacity(.1),
                            ),
                            width: width,
                            // height: height * .09,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: InkWell(
                                        onTap: () {},
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor:
                                              kgreyColor.withOpacity(.1),
                                          child: Icon(
                                            Icons.person,
                                            color: kgreyColor.withOpacity(.6),
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: kBlueColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '🤍وَأَن لَّيْسَ لِلْإِنسَانِ إِلَّا مَا سَعَىٰ وَأَنَّ سَعْيَهُ سَوْفَ يُرَىٰ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color:
                                                  kgreyColor.withOpacity(.5)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                const CustomDivider(
                                  indent: 0,
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                const CustomRow(
                                  image: 'assets/images/avatar.png',
                                  color: kBlueColor,
                                  text: 'Avatar',
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: kWhiteColor.withOpacity(.1),
                            ),
                            width: width,
                            child: Column(
                              children: [
                                CustomRow(
                                    text: 'Broadcast Lists',
                                    color: Colors.green.withOpacity(.7),
                                    image: 'assets/images/broadcast.png'),
                                CustomRow(
                                  text: 'Starred Messages',
                                  color: Colors.yellow.withOpacity(.8),
                                  image: 'assets/images/star.png',
                                ),
                                const CustomRow(
                                    text: 'Linked Devices',
                                    color: Colors.blueGrey,
                                    image: 'assets/images/laptop.png'),
                                InkWell(
                                  onTap: () {
                                    cubit.changeMode();
                                    setState(() {});
                                    setChangeAppMode(isDarkk);
                                    log(LoginAndRegisterCubit()
                                        .isDark
                                        .toString());
                                    log(isDarkk.toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Icon(Icons.dark_mode)),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Text('Mood',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: kWhiteColor
                                                    .withOpacity(.9)))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: kWhiteColor.withOpacity(.1),
                            ),
                            width: width,
                            child: const Column(
                              children: [
                                CustomRow(
                                    text: 'Account',
                                    color: kBlueColor,
                                    image: 'assets/images/account.png'),
                                CustomRow(
                                    text: 'Privacy',
                                    color: Colors.blueGrey,
                                    image: 'assets/images/lock.png'),
                                CustomRow(
                                    text: 'Chats',
                                    color: Colors.green,
                                    image: 'assets/images/whatsApp.png'),
                                CustomRow(
                                    text: 'Notifications',
                                    color: Colors.red,
                                    image: 'assets/images/notification.png'),
                                CustomRow(
                                    text: 'Storage and Data',
                                    color: Colors.green,
                                    image: 'assets/images/double_arrows.png'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: kWhiteColor.withOpacity(.1),
                            ),
                            width: width,
                            child: Column(
                              children: [
                                const CustomRow(
                                    text: 'Help',
                                    color: kBlueColor,
                                    image: 'assets/images/letter_i.png'),
                                const CustomRow(
                                    text: 'Tall a Friend',
                                    color: Colors.red,
                                    image: 'assets/images/white_heart.png'),
                                InkWell(
                                  onTap: () async {
                                    try {
                                      cubit.signOut();
                                      await CacheHelper.clearData();
                                      loginScreenEmailController.clear();
                                      loginScreenPasswordController.clear();
                                    } catch (e) {
                                      log(e.toString());
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Icon(Icons.logout_rounded)),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Text('Sign Out',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: kWhiteColor
                                                    .withOpacity(.9)))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
            },
          );
        });
  }
}
