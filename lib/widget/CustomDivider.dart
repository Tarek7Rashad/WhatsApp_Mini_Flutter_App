import 'package:firebase_app/shared/constant.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.indent = 80,
    this.height = 3,
  });

  final double indent;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      indent: indent,
      thickness: 1,
      color: kgreyColor.withOpacity(.2),
    );
  }
}
