import 'dart:developer';

import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/shared/network/local.dart';
import 'package:firebase_app/shared/socialShared/cubit/LoginAndRegisterCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginAndRegisterAppBar extends StatefulWidget {
  const LoginAndRegisterAppBar({
    super.key,
  });
  @override
  State<LoginAndRegisterAppBar> createState() => _LoginAndRegisterAppBarState();
}

late Widget title;

class _LoginAndRegisterAppBarState extends State<LoginAndRegisterAppBar> {
  @override
  void initState() {
    if (isDarkk == false) {
      isDarkk = true;
    }

    log(isDarkk.toString());
    log(LoginAndRegisterCubit().isDark.toString());

    getChangeAppMode();
    super.initState();
  }

  @override
  void dispose() {
    setChangeAppMode(isDarkk);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<LoginAndRegisterCubit>(context);
        title = Text(
          cubit.titles[cubit.currentIndex],
          style: const TextStyle(fontSize: 24),
        );
        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              splashRadius: .00000000001,
              onPressed: () {
                cubit.changeMode();
                setState(() {});
                setChangeAppMode(isDarkk);
                log(LoginAndRegisterCubit().isDark.toString());
                log(isDarkk.toString());
              },
              icon: const Icon(FontAwesomeIcons.moon),
            ),
          ],
          title: title,
        );
      },
    );
  }
}
