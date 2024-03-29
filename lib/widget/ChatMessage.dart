import 'package:firebase_app/model/MessageModel.dart';
import 'package:firebase_app/shared/constant.dart';
import 'package:flutter/material.dart';

class ChatMessageFromSender extends StatelessWidget {
  const ChatMessageFromSender({
    super.key,
    required this.messageModel,
  }) : super();
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          padding:
              const EdgeInsets.only(left: 20, top: 20, bottom: 18, right: 70),
          decoration: BoxDecoration(
              color: kLightGreenColor.withOpacity(.4),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          margin: const EdgeInsets.all(12),
          child: Text(
            messageModel.message,
            style: const TextStyle(color: kSecondryColor, fontSize: 20),
          ),
        ),
        Positioned(
          right: 17,
          bottom: 15,
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              children: [
                Text(
                  "${messageModel.time.toDate().hour}:${messageModel.time.toDate().minute}",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(
                  width: 8,
                ),
                Image.asset(
                  'assets/images/DDD.png',
                  width: 15,
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class ChatMessageFromReceiver extends StatelessWidget {
  const ChatMessageFromReceiver({
    super.key,
    required this.messageModel,
  }) : super();
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 20, top: 20, bottom: 18, right: 70),
            decoration: const BoxDecoration(
                color: kSecondryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            margin: const EdgeInsets.all(12),
            child: Text(
              messageModel.message,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Positioned(
            right: 17,
            bottom: 15,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Row(
                children: [
                  Text(
                    "${messageModel.time.toDate().hour}:${messageModel.time.toDate().minute}",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    'assets/images/DDD.png',
                    width: 15,
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
