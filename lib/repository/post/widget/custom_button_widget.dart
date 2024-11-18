import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool onLoading;
  final String title;

  CustomButtonWidget({
    required this.onTap,
    required this.onLoading,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onLoading ? null : onTap,
      child: onLoading
          ? CircularProgressIndicator(color: Colors.white)
          : Text(title),
    );
  }
}
