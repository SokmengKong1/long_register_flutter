import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acount"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 100),
                child: Icon(
                  Icons.account_circle,
                  size: 200,
                ),
              ),
            ),
            Container(
              child: Text("Hello"),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      child: Text("Hello"),
                    ),
                    Container(
                      child: Text("Hello"),
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: Text(
                          "One",
                          style: TextStyle(color: Colors.indigo),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
