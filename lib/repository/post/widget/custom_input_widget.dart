import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputWidget extends StatelessWidget {
  TextEditingController controller;
  String? hintText, labelText;
  Icon? prefixIcon, suffixIcon;
    CustomInputWidget(
      {super.key,
      required this.controller,
      this.labelText,
      this.hintText,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: "username",
            labelText: "username"),
      ),
    );
  }
}
