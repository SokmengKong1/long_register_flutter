import 'package:add_card_shop/data/remote/Network_url_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Define controllers for each input field
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController profileController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  // Function to send data to the API
  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      // Replace with your actual API endpoint
      var url = Uri.parse("http://194.233.91.140:20099/api/oauth/register");

      // Define the request body
      var requestBody = {
        "firstName": firstNameController.value.text,
        "lastName": lastNameController.value.text,
        "username": usernameController.value.text,
        "email": emailController.value.text,
        "phoneNumber": phoneNumberController.value.text,
        "password": passwordController.value.text,
        "confirmPassword": confirmPasswordController.value.text,
        "profile": profileController.value.text,
        "role": roleController.value.text,
      };

      // Make the POST request
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        // Registration successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration successful")),
        );
      } else {
        // Handle error response
        var responseBody = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: ${responseBody['error']}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField("First Name", firstNameController),
              buildTextField("Last Name", lastNameController),
              buildTextField("Username", usernameController),
              buildTextField("Email", emailController),
              buildTextField("Phone Number", phoneNumberController),
              buildTextField("Password", passwordController, obscureText: true),
              buildTextField("Confirm Password", confirmPasswordController, obscureText: true),
              buildTextField("Profile", profileController),
              buildTextField("Role", roleController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerUser,
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}


