import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/appComponents.dart';
import 'components/auth/login.dart';
import 'components/home/homePage.dart';
import 'components/purchase/cartPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
          baseColor: Colors.white,
          lightSource: LightSource.topLeft,
          depth: 10,
          iconTheme: IconThemeData(color: Colors.black)),
      themeMode: ThemeMode.light,
      home: const Login(),
      routes: {
        '/compo': (context) => const AppComponent(),
        '/login': (context) => const Login(),
        '/home': (context) => const HomePage(),
        '/cart': (context) => CartPage(
              showBackbutton: true,
            ),
      },
    );
  }
}
