import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomflutter3sellers/components/custom_text_field.dart';
import 'package:ecomflutter3sellers/components/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../global/global.dart';
import '../splashScreen/my_splash_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  validateForm() {
    if (emailTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty) {
      //allow user to login
      loginNow();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please provide email and password.")));
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingDialogWidget(
            message: "Checking credentials",
          );
        });

    User? currentUser;

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMessage) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Occurred: \n $errorMessage")));
    });

    if (currentUser != null) {
      checkIfSellerRecordExists(currentUser!);
    }
  }

  checkIfSellerRecordExists(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((record) async {
      if (record.exists) //record exists
      {
        //status is approved
        if (record.data()!["status"] == "approved") {
          await sharedPreferences!.setString("uid", record.data()!["uid"]);
          await sharedPreferences!.setString("email", record.data()!["email"]);
          await sharedPreferences!.setString("name", record.data()!["name"]);
          await sharedPreferences!
              .setString("photoUrl", record.data()!["photoUrl"]);

          //send seller to home screen
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => SplashScreen()));
        } else //status is not approved
        {
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:  Text(
                  "you have BLOCKED by admin.\ncontact Admin: admin@ishop.com")));
        }
      } else //record not exists
      {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content:  Text("This seller's record do not exists.")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "images/seller.png",
              height: MediaQuery.of(context).size.height * 0.40,
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                //email
                CustomTextField(
                  textEditingController: emailTextEditingController,
                  iconData: Icons.email,
                  hintText: "Email",
                  isObsecre: false,
                  enabled: true,
                ),
                //pass
                CustomTextField(
                  textEditingController: passwordTextEditingController,
                  iconData: Icons.lock,
                  hintText: "Password",
                  isObsecre: true,
                  enabled: true,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
              onPressed: () {
                validateForm();
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
