import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce1/Pages/homePage.dart';
import 'package:ecommerce1/commonwidget/allWidgets.dart';
import 'package:ecommerce1/services/authService.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conPass = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: signup()),
    );
  }

  Widget signup() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: backArrow(context),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\nCreate\nyour account",
                  style: GoogleFonts.aBeeZee(
                      fontSize: 24, fontWeight: FontWeight.bold, height: 1.7),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: name,
                  style: GoogleFonts.aBeeZee(),
                  decoration: const InputDecoration(
                      hintText: "Enter your name",
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: email,
                  style: GoogleFonts.aBeeZee(),
                  decoration: const InputDecoration(
                      hintText: "Email address",
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: password,
                  style: GoogleFonts.roboto(),
                  decoration: InputDecoration(
                      hintStyle: GoogleFonts.aBeeZee(),
                      hintText: "Passsword",
                      border: const UnderlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: conPass,
                  style: GoogleFonts.roboto(),
                  decoration: InputDecoration(
                      hintStyle: GoogleFonts.aBeeZee(),
                      hintText: "Confirm Passsword",
                      border: const UnderlineInputBorder()),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                      height: 40,
                      minWidth: 100,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      color: const Color(0xff2D201C),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        if ((password.text == conPass.text) &&
                            email.text.isNotEmpty) {
                          String uuid = await createAccount(
                              email.text, password.text, context);
                          setState(() {
                            loading = true;
                          });
                        }
                      },
                      child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: loading
                              ? const SizedBox(
                                  key: ValueKey('loading'),
                                  width:
                                      25, // Set width of the progress indicator
                                  height: 25,
                                  child: Padding(
                                    padding: EdgeInsets.all(3),
                                    child: CircularProgressIndicator(
                                      strokeWidth:
                                          2, // Optional: Set thickness of the progress indicator
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  "SIGN UP",
                                  style:
                                      GoogleFonts.aBeeZee(color: Colors.white),
                                ))),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "\nor Sign Up with",
                    style: GoogleFonts.aBeeZee(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)),
                        child: CachedNetworkImage(
                            width: 15,
                            height: 15,
                            scale: 1.0,
                            imageUrl:
                                'https://firebasestorage.googleapis.com/v0/b/ecommerce-c93b3.appspot.com/o/assets%2FApple.png?alt=media&token=641e949f-b237-44ed-8057-4d1010f600c7'),
                      ),
                      Container(
                        width: 42,
                        height: 42,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)),
                        child: CachedNetworkImage(
                            width: 15,
                            height: 15,
                            scale: 1.0,
                            imageUrl:
                                'https://firebasestorage.googleapis.com/v0/b/ecommerce-c93b3.appspot.com/o/assets%2FGoogle.png?alt=media&token=1fcd0e6c-ebbc-4b9d-830a-4f88a34c2d04'),
                      ),
                      Container(
                        width: 42,
                        height: 42,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)),
                        child: CachedNetworkImage(
                            width: 15,
                            height: 15,
                            scale: 1.0,
                            imageUrl:
                                'https://firebasestorage.googleapis.com/v0/b/ecommerce-c93b3.appspot.com/o/assets%2Ffacebook.png?alt=media&token=5b9fa041-3361-40b2-bf15-739c07920602'),
                      )
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Already have an account? Log In",
                          style: GoogleFonts.aBeeZee(color: Colors.black),
                        )))
              ],
            ),
          )))
        ],
      ),
    );
  }
}
