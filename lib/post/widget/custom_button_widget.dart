import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  VoidCallback? onTap;
  bool onLoading;
  String? title;
  CustomButtonWidget(
      {super.key, this.onTap, this.onLoading = false, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.all(Radius.circular(14))),
        child: onLoading == true
            ? Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
      ),
    );
  }
}
