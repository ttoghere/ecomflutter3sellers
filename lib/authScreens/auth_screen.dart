import 'package:ecomflutter3sellers/authScreens/sign_up_page.dart';
import 'package:flutter/material.dart';
import '../global/global.dart';
import 'login_page.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: boxDecoration,
          ),
          title: const Text(
            "Multi Vendor",
            style: TextStyle(
              fontSize: 30,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white54,
            indicatorWeight: 6,
            tabs: [
              Tab(
                text: "Login",
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
              Tab(
                text: "Registration",
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration:boxDecoration,
          child: TabBarView(
            children: [
              LoginPage(),
              SignUpPage(),
            ],
          ),
        ),
      ),
    );
  }
}
