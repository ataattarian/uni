import 'package:flutter/material.dart';
import 'package:photo_shop/util/constants/colors_list.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  TextEditingController usernameTextController;
  final String hintText;
  final bool isAnonymous;

  CustomTextFormField({
    Key? key,
    required this.usernameTextController,
    required this.hintText,
    required this.isAnonymous,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: widget.usernameTextController,
        obscureText: widget.isAnonymous ? !_passwordVisible : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorsList.cyan),
          ),
          suffixIcon: widget.isAnonymous
              ? IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: ColorsList.darkBeige,
                  ),
                  onPressed: onVisibilityPressed,
                )
              : null,
        ),
        cursorColor: ColorsList.cyan,
      ),
    );
  }

  void onVisibilityPressed() {
    setState(() => _passwordVisible = !_passwordVisible);
  }
}
