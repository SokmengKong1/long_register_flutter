import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../App_route/route_App.dart';
import '../view/show/show_data/view_model/detail_view.dart';

// class CartIconButton extends StatelessWidget {
//   final DetailView detailView = Get.find(); // Fetch the controller
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<DetailView>(
//       builder: (controller) {
//         print("controller: ${controller.cartCount}");
//         return IconButton(
//           icon: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               const Icon(Icons.shopping_cart, size: 30), // Adjust icon size as needed
//               if (controller.cartCount > 0) // Show badge only if there are items in the cart
//
//                 Positioned(
//                   left: 15,  // Adjust the left position
//                   bottom: 17,  // Adjust the bottom position
//                   child: CircleAvatar(
//                     radius: 10, // Adjust the size of the badge
//                     backgroundColor: Colors.red,
//                     child: Text(
//                        //controller.cartCount.toString(),
//                       controller.cartCount.toString(),
//                       style: const TextStyle(
//                         fontSize: 12, // Adjust font size as needed
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           onPressed: () {
//             Get.toNamed(Route_App.addCardOn); // Navigate to the cart page
//           },
//         );
//       },
//     );
//   }
// }
class CartIconButton extends StatelessWidget {
  final DetailView detailView = Get.find(); // Fetch the controller

  @override
  Widget build(BuildContext context) {
    return Obx(() { // Use Obx to listen to reactive changes
      return IconButton(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            // If loading is true, show a CircularProgressIndicator in the center
            if (detailView.isLoading.value)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                  strokeWidth: 2, // Adjust the stroke width
                ),
              )
            else
              const Icon(Icons.shopping_cart, size: 30), // Main cart icon

            // Show badge if there are items in the cart
            if (detailView.cartCount > 0)
              Positioned(
                left: 15,  // Adjust the position relative to the icon
                bottom: 17,  // Adjust vertical position as needed
                child: CircleAvatar(
                  radius: 10, // Badge size
                  backgroundColor: Colors.red, // Badge color
                  child: Text(
                    detailView.cartCount.toString(), // Cart count
                    style: const TextStyle(
                      fontSize: 12, // Font size for the badge text
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.bold, // Text weight
                    ),
                  ),
                ),
              ),
          ],
        ),
        onPressed: detailView.isLoading.value
            ? null // Disable the button if it's in the loading state
            : () async {
          // Perform the operation of adding the item to the cart
          //await detailView.addToCart(detailView.postResponse.value);
          // Optionally navigate to the cart page (uncomment if needed)
           Get.toNamed(Route_App.addCardOn);
        },
      );
    });
  }
}
