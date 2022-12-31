import 'package:flutter/material.dart';
import 'package:photo_shop/util/constants/colors_list.dart';

import 'signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorsList.beige,
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(child: SignUpForm()),
        ),
      ),
    );
  }
}
