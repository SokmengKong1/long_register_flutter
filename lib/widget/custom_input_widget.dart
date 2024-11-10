// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CustomInputWidget extends StatelessWidget {
//   TextEditingController controller;
//   String? hintText, labelText;
//   Icon? prefixIcon, suffixIcon;
//   final String? Function(String?)? validator;
//   final bool obscureText;
//   CustomInputWidget(
//       {super.key,
//       required this.controller,
//       this.labelText,
//       this.hintText,
//       this.prefixIcon,
//         this.suffixIcon,
//         this.validator,
//         this.obscureText =false
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           prefixIcon: prefixIcon,
//           suffixIcon: suffixIcon,
//           hintText: hintText,
//           labelText: labelText,
//           border: OutlineInputBorder(),
//         ),
//         validator: validator,
//       ),
//     );
//     }
//   }

// custom_input_widget.dart
import 'package:flutter/material.dart';

class CustomInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Icon prefixIcon;
  final Widget? suffixIcon; // Changed from Icon? to Widget?
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const CustomInputWidget({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon, // Updated parameter type
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon, // Now accepts any widget, including IconButton
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
