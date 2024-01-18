// ignore_for_file: unnecessary_null_comparison
import 'package:firebase_app/firebase_options.dart';
import 'package:firebase_app/layout/SocialLayout.dart';
import 'package:firebase_app/screens/ChatScreen.dart';
import 'package:firebase_app/screens/loginScreen.dart';
import 'package:firebase_app/screens/signUpScreen.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/shared/network/local.dart';
import 'package:firebase_app/shared/socialShared/cubit/LoginAndRegisterCubit.dart';
import 'package:firebase_app/shared/socialShared/cubit/SocialCubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  uId = CacheHelper.getData2(key: 'uId');
  if (uId.isNotEmpty) {
    widget = const SocialLayout();
  } else if (uId == '') {
    widget = const LoginScreen();
  }
  runApp(const SocialApp());
}

class SocialApp extends StatelessWidget {
  const SocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginAndRegisterCubit()..isDark,
        ),
        BlocProvider(
          create: (context) => SocialCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return FutureBuilder(
            future: getChangeAppMode(),
            builder: (context, snapshot) {
              bool dark = snapshot.data ?? false;
              LoginAndRegisterCubit().isDark = dark;
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: dark ? ThemeMode.dark : ThemeMode.light,
                home: widget,
                routes: {
                  LoginScreen.id: (context) => const LoginScreen(),
                  SignUpScreen.id: (context) => const SignUpScreen(),
                  SocialLayout.id: (context) => const SocialLayout(),
                  ChatScreen.id: (context) => const ChatScreen()
                },
                theme: ThemeData(
                  brightness: Brightness.light,
                  scaffoldBackgroundColor: kMainColor,
                  textTheme: const TextTheme(
                    bodyLarge: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor),
                    titleMedium:
                        TextStyle(fontSize: 20, color: kLightGreenColor),
                  ),
                  cardColor: kLightGreenColor,
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      backgroundColor: kBlackColor,
                      selectedIconTheme: IconThemeData(color: kWhiteColor),
                      unselectedIconTheme: IconThemeData(color: kMainColor)),
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: kBlackColor,
                  textTheme: const TextTheme(
                    bodyLarge: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: kWhiteColor),
                    titleMedium: TextStyle(fontSize: 20, color: kWhiteColor),
                  ),
                  cardColor: kBlackColor,
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      backgroundColor: kLightGreenColor,
                      selectedIconTheme: IconThemeData(color: kWhiteColor),
                      unselectedIconTheme: IconThemeData(color: kMainColor)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
