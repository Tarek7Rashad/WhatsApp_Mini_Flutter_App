// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, unnecessary_null_comparison, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screens/loginScreen.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/shared/network/local.dart';
import 'package:firebase_app/shared/socialShared/cubit/LoginAndRegisterCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SocialLayout extends StatefulWidget {
  const SocialLayout({super.key});
  static const String id = 'SocialLayout';

  @override
  State<SocialLayout> createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout> {
  CollectionReference users =
      FirebaseFirestore.instance.collection(kCollectionName);
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
      listener: (context, state) {
        if (state is SignOutState) {
          // Navigator.pop(context);
          getChangeAppMode();
          Navigator.of(context).pushReplacementNamed(LoginScreen.id);
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<LoginAndRegisterCubit>(context);
        return ModalProgressHUD(
          progressIndicator: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kgreyColor.withOpacity(.1),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: kMainColor,
                strokeWidth: 4,
              ),
            ),
          ),
          inAsyncCall: cubit.logOutIsLoading,
          child: SafeArea(
            child: Scaffold(
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                  mouseCursor: MouseCursor.defer,
                  backgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 30,
                  // showSelectedLabels: false,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeButtomNavigationBar(index);
                    setState(() {});
                  },
                  items: [
                    BottomNavigationBarItem(
                      
                        label: 'Updates',
                        icon: SvgPicture.asset(
                          'assets/images/signal-messenger.svg',
                          width: 32,
                          height: 32,
                          color: cubit.currentIndex == 0
                              ? kWhiteColor
                              : kMainColor,
                        )),
                    const BottomNavigationBarItem(
                        label: 'Calls', icon: FaIcon(FontAwesomeIcons.phone)),
                    const BottomNavigationBarItem(
                        label: 'Communities',
                        icon: Icon(FontAwesomeIcons.users)),
                    const BottomNavigationBarItem(
                        label: 'Chats',
                        icon: Icon(FontAwesomeIcons.solidComments)),
                    const BottomNavigationBarItem(
                        label: 'Settings', icon: Icon(FontAwesomeIcons.gear))
                  ]),
            ),
          ),
        );
      },
    );
  }
}
