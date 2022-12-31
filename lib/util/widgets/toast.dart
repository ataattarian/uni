import 'package:flutter/material.dart';
import 'package:photo_shop/util/constants/colors_list.dart';

void showToast(BuildContext context,String content){
  var snackBar = SnackBar(
    content: Text(content),
    backgroundColor: ColorsList.shadow,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}