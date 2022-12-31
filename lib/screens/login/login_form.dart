import 'package:flutter/material.dart';
import 'package:photo_shop/util/api/dio_client.dart';
import 'package:photo_shop/util/constants/colors_list.dart';
import 'package:photo_shop/util/widgets/animated_progress_indicator.dart';
import 'package:photo_shop/util/widgets/custom_text_form_field.dart';
import 'package:photo_shop/util/widgets/toast.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [_usernameTextController, _passwordTextController];
    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }
    setState(() => _formProgress = progress);
  }

  void authorization() async {
    DioClient client = DioClient();
    if (await client.login(username: _usernameTextController.text, password: _passwordTextController.text) == 200) {

     Navigator.of(context).pushNamed('/main_page');
    } else {
      setState(() {
        showToast(context, 'Something went wrong! Try again.');
        _usernameTextController.clear();
        _passwordTextController.clear();
      });
    }
  }

  void _signUpNavigator() => Navigator.of(context).pushNamed('/signup');

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
            child: Text('Log In', style: Theme.of(context).textTheme.headline4),
          ),
          CustomTextFormField(
            usernameTextController: _usernameTextController,
            hintText: 'Username',
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
                const Text('Don\'t have an account? '),
                GestureDetector(
                  onTap: _signUpNavigator,
                  child: const Text('Sign up',
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
              child: const Text('LOG IN'),
            ),
          ),
        ],
      ),
    );
  }
}
