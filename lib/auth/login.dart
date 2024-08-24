import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce1/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Pages/homePage.dart';
import '../services/authService.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  late SharedPreferences preferences;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(PREF_USER_CRED)) {
      email.text = preferences.getString('email')!;
      pass.text = preferences.getString('pass')!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: login(false)),
    );
  }

  Widget login(bool isTab) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "\n\nLogin into\nyour account",
                style: GoogleFonts.aBeeZee(
                    fontSize: 24, fontWeight: FontWeight.bold, height: 1.7),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                style: GoogleFonts.aBeeZee(),
                controller: email,
                decoration: const InputDecoration(
                    hintText: "Email address", border: UnderlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: pass,
                style: GoogleFonts.roboto(),
                decoration: InputDecoration(
                    hintStyle: GoogleFonts.aBeeZee(),
                    hintText: "Passsword",
                    border: const UnderlineInputBorder()),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.center,
                  child: FilledButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff2D201C))),
                      onPressed: () {
                        if (email.text.isNotEmpty && pass.text.isNotEmpty) {
                          preferences.setBool(PREF_USER_CRED, true);
                          preferences.setString(PREF_EMAIL, email.text);
                          preferences.setString(PREF_PASS, pass.text);
                          loginUser(email.text, pass.text, context);
                        }
                      },
                      child: const Text("LOG IN"))),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "\nor Login with",
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
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text(
                        "Don't have an account? Sign Up",
                        style: GoogleFonts.aBeeZee(color: Colors.black),
                      )))
            ],
          ),
        ));
  }
}
