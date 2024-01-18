// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_app/helper/showSnackBar.dart';
import 'package:firebase_app/shared/constant.dart';
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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String id = 'SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

bool obscureTextPassword = true;
bool obscureTextCofirmPassword = true;
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
      listener: (context, state) {
        if (state is SocialSignUpSuccessState) {}
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
          inAsyncCall: cubit.isLoading,
          child: SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: PreferredSize(
                  preferredSize: Size(width, height * .07),
                  child: const LoginAndRegisterAppBar()),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: signUpFormKey,
                  autovalidateMode: signUpAutovalidateMode,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 22, right: 22, top: height * .02),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).cardColor,
                      ),
                      width: width * width,
                      height: height * .86,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: height * .01,
                          ),
                          Text(
                            'SIGN UP',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            height: height * .03,
                          ),
                          CustomTextFormField(
                            controller: signUpScreenUserNameController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "username is required";
                              } else {
                                return null;
                              }
                            },
                            hint: 'UserName',
                            label: 'UserName',
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          CustomTextFormField(
                            controller: signUpScreenEmailController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "email is a required field";
                              } else if (!RegExp(
                                      r'^[\w-]+(\.[\w-]+)*@gmail\.com$')
                                  .hasMatch(value)) {
                                return "enter a valid email address";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              cubit.signUpEmail = value;
                            },
                            hint: 'Email',
                            label: 'Email',
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          CustomTextFormField(
                            controller: signUpScreenPhoneController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "phone is a required field";
                              }
                              return null;
                            },
                            hint: 'Phone',
                            label: 'Phone',
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          CustomTextFormField(
                            controller: signUpScreenPasswordController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "password is required";
                              } else if (value.length <= 6) {
                                return "Password is too weak";
                              } else if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[@-_\$ /]).*$')
                                  .hasMatch(value)) {
                                return "must be uppercase & lowercase letter, number";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              cubit.signUpPassword = value;
                            },
                            obscureText: obscureTextPassword,
                            suffix: IconButton(
                                color: kBlackColor,
                                onPressed: () {
                                  if (obscureTextPassword &&
                                      signUpScreenPasswordController
                                          .text.isNotEmpty) {
                                    obscureTextPassword = false;
                                    setState(() {});
                                  } else {
                                    obscureTextPassword = true;
                                    setState(() {});
                                  }
                                },
                                icon: obscureTextPassword
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
                            height: height * .01,
                          ),
                          CustomTextFormField(
                            controller: signUpScreenConfirmPasswordController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return " this is required field ";
                              } else if (value.isNotEmpty &&
                                  signUpScreenConfirmPasswordController.text !=
                                      signUpScreenPasswordController.text) {
                                return "password dosen't match ";
                              } else {
                                log(value.toString());
                              }
                              return null;
                            },
                            obscureText: obscureTextCofirmPassword,
                            suffix: IconButton(
                                color: kBlackColor,
                                onPressed: () {
                                  if (obscureTextCofirmPassword &&
                                      signUpScreenConfirmPasswordController
                                          .text.isNotEmpty) {
                                    obscureTextCofirmPassword = false;
                                    setState(() {});
                                  } else {
                                    obscureTextCofirmPassword = true;
                                    setState(() {});
                                  }
                                },
                                icon: obscureTextCofirmPassword
                                    ? const Icon(
                                        Icons.lock,
                                        color: kWhiteColor,
                                      )
                                    : const Icon(
                                        FontAwesomeIcons.unlock,
                                        color: kWhiteColor,
                                      )),
                            hint: 'Confirm Password',
                            label: 'Confirm Password',
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          CustomButton(
                            onPressed: () async {
                              if (signUpFormKey.currentState!.validate()) {
                                cubit.isLoading = true;
                                setState(() {});
                                try {
                                  await cubit.signUp(
                                    email: signUpScreenEmailController.text,
                                    password:
                                        signUpScreenPasswordController.text,
                                    name: signUpScreenUserNameController.text,
                                    phone: signUpScreenPhoneController.text,
                                  );
                                  kUserName =
                                      signUpScreenUserNameController.text;
                                  Navigator.of(context).pop();
                                  signUpScreenEmailController.clear();
                                  signUpScreenUserNameController.clear();
                                  signUpScreenPhoneController.clear();
                                  signUpScreenPasswordController.clear();
                                  signUpScreenConfirmPasswordController.clear();
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    showSnackBar(
                                        context, 'Password Is Too Weak');
                                  } else if (e.code == 'email-already-in-use') {
                                    showSnackBar(
                                        context, 'Email Already Exist');
                                  }
                                } catch (e) {
                                  showSnackBar(context, e.toString());
                                }
                                cubit.isLoading = false;
                                setState(() {});
                              } else {
                                signUpAutovalidateMode =
                                    AutovalidateMode.always;
                                setState(() {});
                              }
                            },
                            width: width,
                            text: 'SIGN UP',
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextButton(
                                text: "Have Account ? ",
                                onPressed: () {},
                              ),
                              CustomTextButton(
                                text: 'LOGIN',
                                onPressed: () {
                                  Navigator.pop(context);
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
