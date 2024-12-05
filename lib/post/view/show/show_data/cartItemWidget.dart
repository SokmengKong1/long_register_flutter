import 'package:flutter/material.dart';
import '../../../../model/postRegister/product/post_response.dart';


class CartItemWidget extends StatelessWidget {
  final PostResponse product;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemWidget({
    required this.product,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Remove icon
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onRemove, // Trigger remove action
          ),

          // Product quantity and increment/decrement buttons
          Row(
            children: [
              // Decrease button
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.black),
                onPressed: onDecrease, // Trigger decrease quantity
              ),

              // Display quantity
              Text(
                '${product.quantity}', // Display the current quantity
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              // Increase button
              IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: onIncrease, // Trigger increase quantity
              ),
            ],
          ),

          // Optionally, add a price or any other info on the right
          // Text('\$${product.price}', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
