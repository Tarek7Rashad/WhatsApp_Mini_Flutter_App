import 'package:firebase_app/shared/constant.dart';
import 'package:flutter/material.dart';

class CustomCommunityRow extends StatelessWidget {
  const CustomCommunityRow(
      {super.key, required this.width, required this.icon, required this.text});

  final double width;
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: kgreyColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: icon,
            ),
          ),
          SizedBox(
            width: width * .05,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
