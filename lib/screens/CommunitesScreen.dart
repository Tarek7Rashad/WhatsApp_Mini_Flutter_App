import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/widget/CustomCommunityRow.dart';
import 'package:firebase_app/widget/CustomDivider.dart';
import 'package:flutter/material.dart';

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: height * 0.09,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Communities',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * .05,
                ),
                Container(
                  height: height * .09,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kWhiteColor.withOpacity(.1)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: kgreyColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Icon(Icons.groups_2_rounded),
                              ),
                            ),
                            Positioned(
                              bottom: -3,
                              right: -3,
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                    color: kBlueColor,
                                    borderRadius: BorderRadius.circular(100)),
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
                        SizedBox(
                          width: width * .05,
                        ),
                        const Text(
                          'New Community',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .05,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kWhiteColor.withOpacity(.1),
                  ),
                  child: Column(
                    children: [
                      CustomCommunityRow(
                        width: width,
                        text: "Community One",
                        icon: const Icon(Icons.groups_2_rounded),
                      ),
                      const CustomDivider(
                        height: 20,
                        indent: 16,
                      ),
                      CustomCommunityRow(
                        width: width,
                        text: "Group 1",
                        icon: const Icon(Icons.group_sharp),
                      ),
                      const CustomDivider(
                        height: 20,
                        indent: 93,
                      ),
                      CustomCommunityRow(
                        width: width,
                        text: "Group 2",
                        icon: const Icon(Icons.group_sharp),
                      ),
                      const CustomDivider(
                        height: 20,
                        indent: 93,
                      ),
                      CustomCommunityRow(
                        width: width,
                        text: "Group 3",
                        icon: const Icon(Icons.group_sharp),
                      ),
                      const CustomDivider(
                        height: 20,
                        indent: 93,
                      ),
                      CustomCommunityRow(
                        width: width,
                        text: "Group 4",
                        icon: const Icon(Icons.group_sharp),
                      ),
                      const CustomDivider(
                        height: 20,
                        indent: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'See All ',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: kWhiteColor.withOpacity(.5)),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                              color: kWhiteColor.withOpacity(.5),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
