import 'package:ecommerce1/Pages/Purchase/checkout.dart';
import 'package:ecommerce1/Pages/appComponents.dart';
import 'package:ecommerce1/Pages/Purchase/cartPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Pages/homePage.dart';
import 'auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      theme: const NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      home: const Login(),
      routes: {
        '/compo': (context) => AppComponent(),
        '/login': (context) => Login(),
        '/home': (context) => HomePage(),
        '/cart': (context) => CartPage(
              showBackbutton: true,
            ),
        '/checkout': (context) => CheckOut()
      },
    );
  }
}
