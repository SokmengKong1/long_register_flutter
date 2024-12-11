import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../view/show/show_data/view_model/detail_view.dart';

class RemoveAllButton extends StatelessWidget {
  final DetailView detailView = Get.find(); // Fetch the controller

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Trigger the removal of all items from the cart
        await detailView.removeAllItemsFromCart();

        // Optionally, show a message or navigate to another screen
        Get.snackbar('Cart', 'All items have been removed from your cart');
      },
      child: Text("Remove All Items from Cart"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Button color
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: TextStyle(fontSize: 16),
      ),
    );
  }
}
