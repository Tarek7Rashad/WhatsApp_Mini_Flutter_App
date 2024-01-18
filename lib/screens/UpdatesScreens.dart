import 'package:firebase_app/model/CreateUserModel.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/shared/network/remote.dart';
import 'package:firebase_app/widget/CustomAppBar.dart';
import 'package:firebase_app/widget/CustomDivider.dart';
import 'package:flutter/material.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

List<CreateUserModel> usersList = [];
bool isClicked = false;

class _UpdatesScreenState extends State<UpdatesScreen> {
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
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: height * .04,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(
                      'assets/images/images-removebg-preview.png',
                      color: kBlueColor,
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        CustomAppBar(
                          width: width,
                          text: 'Updates',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: kWhiteColor.withOpacity(.15),
                              child: const Icon(
                                Icons.add,
                                color: kBlueColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * .02,
                      ),
                      Container(
                          color: kWhiteColor.withOpacity(.1),
                          width: width,
                          height: height * .09,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          kgreyColor.withOpacity(.1),
                                      child: Icon(
                                        Icons.person,
                                        color: kgreyColor.withOpacity(.6),
                                        size: 50,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 1,
                                      right: 1,
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                            color: kBlueColor,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.add,
                                            color: kWhiteColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'My Status',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Add to my status',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: kgreyColor.withOpacity(.5)),
                                  )
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Expanded(
                    child: Container(
                      width: width,
                      color: kWhiteColor.withOpacity(.1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: SizedBox(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: usersList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    width: 2,
                                                    color: kBlueColor)),
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  kgreyColor.withOpacity(.2),
                                              child: Icon(
                                                Icons.person,
                                                color:
                                                    kgreyColor.withOpacity(.6),
                                                size: 50,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              usersList[index].name,
                                              style:
                                                  const TextStyle(fontSize: 24),
                                            ),
                                            Text(
                                              usersList[index].email,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: kgreyColor
                                                      .withOpacity(.6)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const CustomDivider(
                                      indent: 77,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
