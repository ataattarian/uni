// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:photo_shop/cart/cart_screen.dart';
import 'package:photo_shop/models/cart.dart';
import 'package:photo_shop/models/picture_model.dart';
import 'package:photo_shop/models/user.dart';
import 'package:photo_shop/screens/category_screen.dart';
import 'package:photo_shop/util/api/dio_client.dart';
import 'package:photo_shop/util/constants/colors_list.dart';
import 'package:photo_shop/util/constants/current_data.dart';
import 'package:photo_shop/util/widgets/photo_grid.dart';
import 'package:photo_shop/util/widgets/photo_slider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<PictureModel> _pictures = [];

  getPics() async {
    DioClient client = DioClient();
    _pictures = await client.getPics();
  }

  @override
  Widget build(BuildContext context) {
    getPics();
    return FutureBuilder(
      future: getPics(),
      builder: (context, AsyncSnapshot snapshot) => Scaffold(
        backgroundColor: ColorsList.beige,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorsList.darkBeige.withOpacity(0.5),
          elevation: 1.0,
          toolbarHeight: 80.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CurrentData.isLoggedIn()
                      ? IconButton(
                          padding: const EdgeInsets.all(15.0),
                          onPressed: _onCartPressed,
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: ColorsList.cyan,
                            size: 30.0,
                          ))
                      : const SizedBox(),
                  CurrentData.isLoggedIn()
                      ? IconButton(
                      padding: const EdgeInsets.all(15.0),
                      onPressed: _onProfileClicked,
                      icon: const Icon(
                        Icons.list_alt_rounded,
                        color: ColorsList.cyan,
                        size: 30.0,
                      ))
                      : const SizedBox(),
                  GestureDetector(
                    onTap: _onCatPressed,
                    child: const Text("CATEGORIES",
                      style: TextStyle(
                          color: ColorsList.cyan,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: _onLogPressed,
                    child: Text(
                      !CurrentData.isLoggedIn() ? "LOG IN" : "LOG OUT",
                      style: const TextStyle(
                          color: ColorsList.cyan,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  )),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: PhotoSlider(
                    pictures:
                        _pictures.length > 4 ? _pictures.sublist(0, 3) : []),
              ),
              PhotoGrid(pictures: _pictures),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogPressed() async {
    if (!CurrentData.isLoggedIn()) {
      Navigator.of(context).pushNamed('/logIn');
    } else {
      CurrentData.user = User();
      CurrentData.cart = Cart();
    }
  }

  _onProfileClicked(){
    Navigator.of(context).pushNamed('/profile');
  }

  void _onCartPressed() => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CartScreen(cart:CurrentData.cart)),
  );

  void _onCatPressed() => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CategoryScreen()),
  );
}
