import 'package:firebase_app/shared/constant.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.label,
    this.controller,
    this.validate,
    this.onChanged,
    this.suffix,
    this.obscureText = false,
  });
  final String hint;
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final Function(String)? onChanged;
  final IconButton? suffix;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        obscureText: obscureText,
        cursorColor: kWhiteColor,
        style: const TextStyle(fontSize: 18, color: kWhiteColor),
        controller: controller,
        validator: validate,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffix,

          hintText: hint,
          hintStyle: const TextStyle(color: kgreyColor, fontSize: 20),
          labelText: label,
          labelStyle: const TextStyle(color: kgreyColor, fontSize: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: .3, color: kWhiteColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: .3, color: kWhiteColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: .7, color: kWhiteColor),
          ),
          // errorText: "* Required",
          errorStyle: const TextStyle(fontSize: 16),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: .7, color: kWhiteColor),
          ),
        ),
      ),
    );
  }
}
