import 'package:flutter/material.dart';
import 'package:photo_shop/cart/profile_screen.dart';
import 'package:photo_shop/screens/login/login_screen.dart';
import 'package:photo_shop/screens/mainpage/main_page.dart';

import 'screens/signup/signup_screen.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      routes: {
        '/logIn': (context) => const LogInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/main_page': (context) => const MainPage(),
        '/profile': (context) => const ProfileScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

