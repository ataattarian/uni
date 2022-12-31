import 'package:flutter/material.dart';
import 'package:photo_shop/screens/login/login_form.dart';
import 'package:photo_shop/util/constants/colors_list.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorsList.beige,
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(child: LogInForm()),
        ),
      ),
    );
  }
}
