// class AddCardon extends StatelessWidget {
//   final DetailView detailView = Get.find(); // Get the controller that manages cart data
//   final PostResponse showData =
//       Get.arguments; // Retrieve the passed PostResponse object
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add to Cart"),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.shopping_cart),
//             onPressed: () {
//               // Navigate to the cart page or show a dialog
//               Get.snackbar("Cart", "Go to cart page");
//             },
//           ),
//         ],
//       ),
//       body: GetBuilder<DetailView>(
//         builder: (_) {
//           // If the cart is empty, show a message
//           if (detailView.cartProduct.isEmpty) {
//             return const Center(
//               child: Text("Your cart is empty!"),
//             );
//           }
//
//           // Display cart items
//           return ListView.builder(
//             itemCount: detailView.cartProduct.length,
//             itemBuilder: (context, index) {
//               final product = detailView.cartProduct[index];
//
//               return Container(
//                 padding: const EdgeInsets.all(10),
//                 margin: const EdgeInsets.symmetric(vertical: 5),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Product Image
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         "${ApiUrl.imageViewPath}${showData.image}",
//                         fit: BoxFit.cover,
//                         width: 60,
//                         height: 60,
//                       ),
//                     ),
//                     // Product Name and Quantity
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product.category?.name ?? "No Title",
//                           style: const TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           // product.title ?? "No Title",
//                           showData.id.toString() ?? "",
//                           style: const TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.normal),
//                         ),
//                         Text(
//                             "Quantity: ${product.quantity}"), // Display quantity
//                       ],
//                     ),
//                     // Total Price
//                     Text(
//                       "\$${(product.totalPrice ?? 0.0).toStringAsFixed(2)}", // Safely format the price
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                     // Quantity Controls
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () => detailView.decreaseQuantity(product),
//                           icon: const Icon(Icons.remove),
//                         ),
//                         Text("${product.quantity}"),
//                         IconButton(
//                           onPressed: () => detailView.increaseQuantity(product),
//                           icon: const Icon(Icons.add),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//
//
//     );
//   }
// }