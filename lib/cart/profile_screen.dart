// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:photo_shop/cart/cart_screen.dart';
import 'package:photo_shop/models/cart.dart';
import 'package:photo_shop/util/api/dio_client.dart';
import 'package:photo_shop/util/constants/colors_list.dart';
import 'package:photo_shop/util/widgets/description_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Cart> _paidCarts = [];

  getCarts() async {
    DioClient client = DioClient();
    _paidCarts = await client.getCarts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCarts(),
        builder: (context, snapshot) {
          return Scaffold(
              backgroundColor: ColorsList.beige,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    padding: const EdgeInsets.all(15.0),
                    onPressed: _onHomePressed,
                    icon: const Icon(
                      Icons.home,
                      color: ColorsList.cyan,
                      size: 30.0,
                    )),
              ),
              body: ListView.separated(
                padding: const EdgeInsets.all(30.0),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  Cart cart = _paidCarts[index];
                  return GestureDetector(
                    onTap: () => _onTap(cart),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: ColorsList.shadow)),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Image.network(
                              'http://185.110.190.249:3535${cart.getPic(0).image}',
                              width: 200,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Spacer(flex: 1),
                          DescriptionItem(
                              title: "Name", description: '${cart.getId()}'),
                          const Spacer(flex: 1),
                          DescriptionItem(
                              title: "Total Price",
                              description: '${cart.getTotalPrice()}'),
                          const Spacer(flex: 3),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _paidCarts.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 20.0),
              ));
        });
  }

  void _onHomePressed() => Navigator.of(context).pop();

  void _onTap(Cart cart) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartScreen(cart: cart)),
    );
  }
}
