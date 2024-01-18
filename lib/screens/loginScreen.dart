// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_app/helper/showSnackBar.dart';
import 'package:firebase_app/layout/SocialLayout.dart';
import 'package:firebase_app/screens/signUpScreen.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/shared/network/local.dart';
import 'package:firebase_app/shared/socialShared/cubit/LoginAndRegisterCubit.dart';
import 'package:firebase_app/widget/LoginAndRegisterAppBar.dart';
import 'package:firebase_app/widget/CustomButton.dart';
import 'package:firebase_app/widget/CustomTextButton.dart';
import 'package:firebase_app/widget/CustomTextFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool loginObscureText = true;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
      listener: (context, state) {
        if (state is SocialLoginFailureState) {
          log('Error Is Happened');
        }

        if (state is SocialLoginSuccessState) {
          CacheHelper.saveData(key: 'uId', value: state.uId!).then((value) {
            // Navigator.of(context).pushNamed(SocialLayout.id);
          });
          getChangeAppMode();
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
          inAsyncCall: cubit.loginIsLoading,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: PreferredSize(
                  preferredSize: Size(width, height * .09),
                  child: const LoginAndRegisterAppBar()),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: loginFormKey,
                  autovalidateMode: loginAutovalidateMode,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 22, right: 22, top: height * .07),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).cardColor,
                      ),
                      width: width * width,
                      height: height * .7,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * .07,
                          ),
                          Text(
                            'SIGN IN',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            height: height * .07,
                          ),
                          CustomTextFormField(
                            controller: loginScreenEmailController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "email is a required field";
                              } else if (!RegExp(
                                      r'^[\w-]+(\.[\w-]+)*@gmail\.com$')
                                  .hasMatch(value)) {
                                return "enter a valid email address";
                              } else {}
                              return null;
                            },
                            onChanged: (value) {
                              cubit.email = value;
                            },
                            hint: 'Email',
                            label: 'Email',
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          CustomTextFormField(
                            controller: loginScreenPasswordController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "password is required";
                              } else {}
                              return null;
                            },
                            onChanged: (value) {
                              cubit.password = value;
                            },
                            obscureText: loginObscureText,
                            suffix: IconButton(
                                color: kBlackColor,
                                onPressed: () {
                                  if (loginObscureText &&
                                      loginScreenPasswordController
                                          .text.isNotEmpty) {
                                    loginObscureText = false;
                                    setState(() {});
                                  } else {
                                    loginObscureText = true;
                                    setState(() {});
                                  }
                                },
                                icon: loginObscureText
                                    ? const Icon(
                                        Icons.lock,
                                        color: kWhiteColor,
                                      )
                                    : const Icon(
                                        FontAwesomeIcons.unlock,
                                        color: kWhiteColor,
                                      )),
                            hint: 'Password',
                            label: 'Password',
                          ),
                          SizedBox(
                            height: height * .07,
                          ),
                          CustomButton(
                            onPressed: () async {
                              try {
                                if (loginFormKey.currentState!.validate()) {
                                  cubit.loginIsLoading = true;
                                  setState(() {});
                                  await cubit.signIn(
                                      email: loginScreenEmailController.text,
                                      password:
                                          loginScreenPasswordController.text);

                                  Navigator.of(context).pushReplacementNamed(
                                      SocialLayout.id,
                                      arguments:
                                          loginScreenEmailController.text);
                                } else {
                                  loginAutovalidateMode =
                                      AutovalidateMode.always;
                                  setState(() {});
                                }
                              } on FirebaseAuthException catch (e) {
                                log(e.toString());
                                showSnackBar(
                                    context, 'Email Or Password Is Invalid');
                                if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                                  showSnackBar(
                                      context, 'email or password is invalid');
                                } else if (e.code == 'wrong-password') {
                                  showSnackBar(context,
                                      'wrong password provided for that user');
                                } else if (!RegExp(
                                        r'^[\w-]+(\.[\w-]+)*@gmail\.com$')
                                    .hasMatch(cubit.email)) {
                                  showSnackBar(
                                      context, 'enter valid email or password');
                                } else {
                                  showSnackBar(context, 'wrong password');
                                }
                              } catch (e) {
                                log(e.toString());
                                showSnackBar(context, 'Error');
                              }
                              cubit.loginIsLoading = false;
                              setState(() {});
                            },
                            width: width,
                            text: 'SIGN IN',
                          ),
                          SizedBox(
                            height: height * .03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Haven't Account ? ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: kWhiteColor.withOpacity(.7)),
                              ),
                              CustomTextButton(
                                text: 'SIGN UP',
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(SignUpScreen.id);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
