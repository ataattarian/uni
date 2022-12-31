import 'package:flutter/material.dart';
import 'package:photo_shop/util/api/dio_client.dart';
import 'package:photo_shop/util/constants/current_data.dart';
import 'package:photo_shop/util/widgets/toast.dart';

import '../../util/constants/colors_list.dart';
import '../../util/widgets/animated_progress_indicator.dart';
import '../../util/widgets/custom_text_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController,
      _passwordTextController
    ];
    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }
    setState(() => _formProgress = progress);
  }

  void authorization() async {
    DioClient client = DioClient();
    CurrentData.user.setUser(
        first_name: _firstNameTextController.text,
        last_name: _lastNameTextController.text,
        email: _usernameTextController.text,
        password: _passwordTextController.text);
    if (await client.register() == 201) {
      setState(() => showToast(context, 'Your account was created successfully. Please log in.'));
      Navigator.of(context).pushNamed('/logIn');
    } else {
      setState(() => showToast(context, 'Something went wrong! Try again.'));
    }
  }

  void _logInNavigator() => Navigator.of(context).pushNamed('/logIn');

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedProgressIndicator(value: _formProgress),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child:
                Text('Sign Up', style: Theme.of(context).textTheme.headline4),
          ),
          CustomTextFormField(
            usernameTextController: _firstNameTextController,
            hintText: 'First Name',
            isAnonymous: false,
          ),
          CustomTextFormField(
            usernameTextController: _lastNameTextController,
            hintText: 'LastName',
            isAnonymous: false,
          ),
          CustomTextFormField(
            usernameTextController: _usernameTextController,
            hintText: 'Email',
            isAnonymous: false,
          ),
          CustomTextFormField(
            usernameTextController: _passwordTextController,
            hintText: 'Password',
            isAnonymous: true,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: _logInNavigator,
                  child: const Text('Log In',
                      style: TextStyle(color: ColorsList.cyan)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : ColorsList.cyan;
                }),
              ),
              onPressed: _formProgress == 1 ? authorization : null,
              child: const Text('SIGN UP'),
            ),
          ),
        ],
      ),
    );
  }
}
