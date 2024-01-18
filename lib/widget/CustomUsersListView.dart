import 'package:firebase_app/model/CreateUserModel.dart';
import 'package:firebase_app/screens/ChatScreen.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:firebase_app/widget/CustomDivider.dart';
import 'package:flutter/material.dart';

class CustomUsersListView extends StatelessWidget {
  const CustomUsersListView({
    super.key,
    required this.usersList,
    this.borderSide,
  });

  final List<CreateUserModel> usersList;
  final BoxBorder? borderSide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: usersList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ChatScreen.id, arguments: {
                'email': usersList[index].email,
                'name': usersList[index].name
              });
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: borderSide),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: kgreyColor.withOpacity(.2),
                          child: Icon(
                            Icons.person,
                            color: kgreyColor.withOpacity(.6),
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usersList[index].name,
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          usersList[index].email,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kgreyColor.withOpacity(.6)),
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
    );
  }
}
