import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/model/CreateUserModel.dart';
import 'package:firebase_app/model/MessageModel.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/shared/network/local.dart';
import 'package:firebase_app/shared/socialShared/cubit/LoginAndRegisterCubit.dart';
import 'package:firebase_app/widget/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String id = "ChatingPage";
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

List<CreateUserModel> allUsers = []; // List to store all users
int n = -1;

class _ChatScreenState extends State<ChatScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // var email = ModalRoute.of(context)!.settings.arguments;
    // var userName = ModalRoute.of(context)!.settings.arguments;
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['email'] == loginScreenEmailController.text) {
      myName = args['name'];
    }
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kAt2, descending: true).snapshots(),
      builder: (context, snapshott) {
        if (snapshott.hasData) {
          List<MessageModel> messagesList = [];
          for (int i = 0; i < snapshott.data!.docs.length; i++) {
            messagesList.add(MessageModel.fromJson(snapshott.data!.docs[i]));
          }
          return BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = BlocProvider.of<LoginAndRegisterCubit>(context);
              return Scaffold(
                appBar: AppBar(
                  toolbarHeight: height * 0.09,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
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
                    IconButton(
                        onPressed: () async {
                          try {
                            cubit.signOut();
                            await CacheHelper.clearData();
                            loginScreenEmailController.clear();
                            loginScreenPasswordController.clear();
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        icon: const Icon(Icons.logout)),
                  ],
                  leading: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios)),
                      const Text(
                        '1',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  title: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: kSecondryColor,
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text('${args!['name']}'),
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    Divider(
                      height: 1,
                      color: kBlackColor.withOpacity(.2),
                      thickness: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                          reverse: true,
                          controller: scrollController,
                          itemCount: messagesList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return messagesList[index].id == args['email']
                                ? ChatMessageFromSender(
                                    messageModel: messagesList[index],
                                  )
                                : ChatMessageFromReceiver(
                                    messageModel: messagesList[index]);
                          }),
                    ),
                    Container(
                      width: double.infinity,
                      color: const Color.fromARGB(125, 0, 56, 56),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              color: kBlueColor,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: controller,
                                onFieldSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    messages.add({
                                      "message": value,
                                      kAt2: DateTime.now(),
                                      kId2: loginScreenEmailController.text,
                                    });
                                  }
                                  controller.clear();
                                  // scrollController.jumpTo(
                                  //     scrollController.position.maxScrollExtent);
                                  scrollController.animateTo(
                                    scrollController.position.minScrollExtent,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: const TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: "Send Message",
                                  hintStyle: const TextStyle(fontSize: 18),
                                  fillColor: kSecondryColor.withOpacity(0.1),
                                  filled: true,
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  constraints:
                                      const BoxConstraints(maxHeight: 40),
                                  suffixIconColor: kMainColor,
                                  suffixIcon: IconButton(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(Icons.note_rounded),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: kBlueColor,
                            ),
                            const Icon(
                              Icons.mic,
                              size: 30,
                              color: kBlueColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
