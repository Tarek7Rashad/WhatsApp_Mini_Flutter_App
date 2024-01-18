import 'package:firebase_app/model/CallsModel.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/widget/CustomAppBar.dart';
import 'package:firebase_app/widget/CustomDivider.dart';
import 'package:flutter/material.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  bool isClicked = true;
  Icon icon = const Icon(Icons.phone_callback_rounded);
  List<CallsModel> usersCalls = [
    CallsModel(
      userName: 'Odi',
      callStatus: 'Outgoing',
    ),
    CallsModel(
      userName: 'Abdelraheem',
      callStatus: 'Missed',
    ),
    CallsModel(
      userName: 'Ahmed',
      callStatus: 'Missed',
    ),
    CallsModel(
      userName: 'Omer',
      callStatus: 'Outgoing',
    ),
    CallsModel(
      userName: 'Oaad',
      callStatus: 'Missed',
    ),
    CallsModel(
      userName: 'Tag',
      callStatus: 'Outgoing',
    ),
    CallsModel(
      userName: 'Mohamed',
      callStatus: 'Missed',
    ),
    CallsModel(
      userName: 'Zyad',
      callStatus: 'Outgoing',
    ),
    CallsModel(
      userName: 'Hammad',
      callStatus: 'Missed',
    ),
    CallsModel(
      userName: 'Hassan',
      callStatus: 'Outgoing',
    ),
    CallsModel(
      userName: 'Kholoud',
      callStatus: 'Outgoing',
    ),
    CallsModel(
      userName: 'Mahmoud',
      callStatus: 'Missed',
    ),
    CallsModel(
      userName: 'Hosam',
      callStatus: 'Missed',
    ),
    CallsModel(
      userName: 'Wael',
      callStatus: 'Outgoing',
    ),
  ];
  List<CallsModel> missedCalls = [];
  getMissed() {
    for (var i = 0; i < usersCalls.length; i++) {
      if (usersCalls[i].callStatus == 'Missed') {
        missedCalls.add(CallsModel(
            callStatus: usersCalls[i].callStatus,
            userName: usersCalls[i].userName));
      }
    }
    missedCalls.toSet();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            toolbarHeight: height * .04,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Edit',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            title: Container(
              height: height * .04,
              width: width * .3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: kWhiteColor.withOpacity(.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: width * .12,
                    height: height * .039,
                    decoration: BoxDecoration(
                        color: isClicked
                            ? kWhiteColor.withOpacity(.5)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                      onPressed: () {
                        isClicked = true;
                        setState(() {});
                      },
                      child: const Text(
                        'All',
                        style: TextStyle(fontSize: 16, color: kWhiteColor),
                      ),
                    ),
                  ),
                  Container(
                    width: width * .15,
                    height: height * .039,
                    decoration: BoxDecoration(
                        color: isClicked
                            ? Colors.transparent
                            : kWhiteColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                      onPressed: () {
                        isClicked = false;
                        if (missedCalls.isEmpty) {
                          getMissed();
                        } else {}
                        setState(() {});
                      },
                      child: const Text(
                        'Missed',
                        style: TextStyle(fontSize: 16, color: kWhiteColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_call,
                    color: kBlueColor,
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                CustomAppBar(width: width, text: 'Calls'),
                SizedBox(
                  height: height * .001,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kWhiteColor.withOpacity(.1),
                      ),
                      width: width,
                      height: height * .09,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: kgreyColor.withOpacity(.1),
                              child: const Icon(
                                Icons.link_rounded,
                                color: kBlueColor,
                                size: 30,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Create Call Link',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Share a link for your WhatsApp call',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: kgreyColor.withOpacity(.5)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .04,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recent',
                    style: TextStyle(fontSize: 18, color: kWhiteColor),
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kWhiteColor.withOpacity(.1),
                    ),
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SizedBox(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: isClicked
                              ? usersCalls.length
                              : missedCalls.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: kgreyColor
                                                      .withOpacity(.2),
                                                  child: Icon(
                                                    Icons.person,
                                                    color: kgreyColor
                                                        .withOpacity(.6),
                                                    size: 50,
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
                                                    isClicked
                                                        ? usersCalls[index]
                                                            .userName
                                                        : missedCalls[index]
                                                            .userName,
                                                    style: const TextStyle(
                                                        fontSize: 24),
                                                  ),
                                                  Row(
                                                    children: [
                                                      isClicked &&
                                                              usersCalls[index]
                                                                      .callStatus ==
                                                                  'Outgoing'
                                                          ? const Icon(Icons
                                                              .call_missed_outgoing_rounded)
                                                          : icon,
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        isClicked
                                                            ? usersCalls[index]
                                                                .callStatus
                                                            : missedCalls[index]
                                                                .callStatus,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: isClicked &&
                                                                    usersCalls[index]
                                                                            .callStatus ==
                                                                        'Outgoing'
                                                                ? kWhiteColor
                                                                    .withOpacity(
                                                                        .7)
                                                                : Colors.red
                                                                    .withOpacity(
                                                                        .7)),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  '),
                                          const Icon(
                                            Icons.info_outline_rounded,
                                            color: kBlueColor,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
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
          )),
    );
  }
}
