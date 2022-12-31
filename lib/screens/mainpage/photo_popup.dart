// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:photo_shop/models/picture_model.dart';
import 'package:photo_shop/util/widgets/description_field.dart';
import 'package:photo_shop/util/constants/colors_list.dart';
import 'package:photo_shop/util/constants/current_data.dart';

class PhotoPopUp extends StatefulWidget {
  final PictureModel photo;

  const PhotoPopUp({Key? key, required this.photo}) : super(key: key);

  @override
  State<PhotoPopUp> createState() => _PhotoPopUpState();
}

class _PhotoPopUpState extends State<PhotoPopUp> {
  late bool _isExpanded;

  late bool _isAdded;

  @override
  void initState() {
    _isExpanded = false;
    _isAdded = CurrentData.cart.isInCart(widget.photo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: !_isExpanded
            ? Container(
                padding: const EdgeInsets.all(8.0),
                width: width / 1.5,
                height: height / 1.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(15.0),
                        onPressed: _onClose,
                        icon: const Icon(Icons.close),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Stack(
                              children: [
                                Image.network(
                                  width: width / 3,
                                  height: height / 2,
                                  widget.photo.image,
                                  fit: BoxFit.cover,
                                ),
                                IconButton(
                                  onPressed: _onExpandPhoto,
                                  icon: const Icon(
                                    Icons.fullscreen,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 2,
                            width: width / 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DescriptionField(photo: widget.photo),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: _onCart,
                                    child: CurrentData.isLoggedIn()
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: 200,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              color: !_isAdded
                                                  ? ColorsList.cyan
                                                  : ColorsList.darkBeige,
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              !_isAdded
                                                  ? "Add To Cart"
                                                  : "Remove From Cart",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0),
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: 200,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              color: ColorsList.darkCyan,
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "Please Log In",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ))
            : Padding(
                padding: const EdgeInsets.all(25.0),
                child: Stack(
                  children: [
                    Image.network(widget.photo.image),
                    IconButton(
                      onPressed: _onExitExpand,
                      icon: const Icon(
                        Icons.fullscreen_exit,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _onClose() => Navigator.pop(context, true);

  void _onExpandPhoto() {
    setState(() => _isExpanded = true);
  }

  void _onExitExpand() {
    setState(() => _isExpanded = false);
  }

  void _onCart() {
    if (CurrentData.isLoggedIn()) {
      setState(() {
        if (_isAdded) {
          CurrentData.cart.removeFromCart(widget.photo);
        } else {
          CurrentData.cart.addToCart(widget.photo);
        }
        _isAdded = !_isAdded;
      });
    } else {
      Navigator.of(context).pushNamed('/logIn');
    }
  }
}
