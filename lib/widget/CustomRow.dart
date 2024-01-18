import 'package:firebase_app/shared/constant.dart';
import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.text,
    required this.image, required this.color,
  });
  final String text;
  final String image;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  image,
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                text,
                style:
                    TextStyle(fontSize: 18, color: kWhiteColor.withOpacity(.9)),
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: kWhiteColor.withOpacity(.4),
          )
        ],
      ),
    );
  }
}
