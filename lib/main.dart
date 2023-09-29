import 'package:fire_base_conn/firebase_options.dart';
import 'package:fire_base_conn/phone_authtication/view/login.dart';
import 'package:fire_base_conn/phone_authtication/view/phone_screen.dart';
import 'package:fire_base_conn/screen/home_screen/view/home_screen.dart';
import 'package:fire_base_conn/screen/login_view/login_screen.dart';
import 'package:fire_base_conn/screen/signup_screen/sign_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => Login(),
          ), GetPage(
            name: '/',
            page: () => Login(),
          ),
        ],
        routes: {
          // "/": (p0) => SignInScreen(),
          // "signup": (p0) => SignUpScreen(),
          // "home": (p0) => Homescreen(),

          '/': (p0) => Login(),
        },
        theme: ThemeData(useMaterial3: true),
      ),
    ),
  );
}
