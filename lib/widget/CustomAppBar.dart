// ignore_for_file: must_be_immutable

import 'package:firebase_app/shared/constant.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key, required this.width, required this.text, this.icon});
  final double width;
  final String text;
  Icon? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: width,
                height: 38,
                child: TextFormField(
                  cursorColor: kWhiteColor,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: kgreyColor.withOpacity(.3)),
                    contentPadding: const EdgeInsets.only(bottom: 10),
                    prefixIcon: Icon(
                      Icons.search,
                      color: kgreyColor.withOpacity(.3),
                    ),
                    fillColor: kgreyColor.withOpacity(.3),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Container(child: icon)
          ],
        )
      ],
    );
  }
}
