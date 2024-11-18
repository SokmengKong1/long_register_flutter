import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/postRegister/product/post_response.dart';

class WidgetShowDetail extends StatelessWidget {
  final PostResponse postResponse;

  WidgetShowDetail({super.key, required this.postResponse});

  @override
  Widget build(BuildContext context) {
    // Debug output for entire postResponse
    return Center(
      child: Text(
        postResponse.title ?? "No ID available",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
