// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:photo_shop/models/cart.dart';
import 'package:photo_shop/models/picture_model.dart';
import 'package:photo_shop/util/api/dio_client.dart';
import 'package:photo_shop/util/constants/colors_list.dart';
import 'package:photo_shop/util/widgets/description_item.dart';
import 'package:photo_shop/util/widgets/toast.dart';

class CartScreen extends StatefulWidget {
  Cart cart;

  CartScreen({Key? key, required this.cart}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsList.beige,
        body: Column(
          children: [
                 Container(
                    height: 100,
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.cart.getStatus() == 'Unpaid' &&
                            widget.cart.numberOfCartItems() != 0?
                        Container(
                          alignment: Alignment.center,
                          width: 300.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: ColorsList.cyan, width: 2.0)),
                          child: Text(
                            "total price : ${widget.cart.getTotalPrice()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: ColorsList.cyan),
                            textAlign: TextAlign.center,
                          ),
                        ):const SizedBox(),
                        Row(
                          children: [
                            widget.cart.getStatus() == 'Unpaid' &&
                                widget.cart.numberOfCartItems() != 0?
                            ElevatedButton(
                                onPressed: _onPayPressed,
                                style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(
                                        const Size(150, 50)),
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorsList.cyan),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)))),
                                child: const Text("Pay",
                                    style: TextStyle(fontSize: 20.0),
                                    textAlign: TextAlign.center)): const SizedBox(),
                            IconButton(
                                padding: const EdgeInsets.all(15.0),
                                onPressed: _onHomePressed,
                                icon: const Icon(
                                  Icons.home,
                                  color: ColorsList.cyan,
                                  size: 30.0,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
            const Divider(
                color: ColorsList.cyan,
                thickness: 2.0,
                indent: 15.0,
                endIndent: 15.0),
            Expanded(
              child: widget.cart.numberOfCartItems() == 0
                  ? const Center(child: Text("Nothing to show"))
                  : ListView.separated(
                      padding: const EdgeInsets.all(30.0),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        PictureModel pic = widget.cart.getPic(index);
                        return Container(
                          padding: const EdgeInsets.all(20.0),
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(color: ColorsList.shadow)),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Image.network(
                                  widget.cart.getId() == null
                                      ? pic.image
                                      : 'http://185.110.190.249:3535${pic.image}',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Spacer(flex: 1),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DescriptionItem(
                                      title: "Name", description: pic.name),
                                  DescriptionItem(
                                      title: "Price",
                                      description: pic.price.toString()),
                                ],
                              ),
                              const Spacer(flex: 20),
                              IconButton(
                                iconSize: 40.0,
                                onPressed: () =>
                                    onDelete(widget.cart.getPic(index)),
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: ColorsList.cyan,
                                ),
                              ),
                              const Spacer(flex: 1),
                            ],
                          ),
                        );
                      },
                      itemCount: widget.cart.numberOfCartItems(),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 20.0),
                    ),
            ),
          ],
        ));
  }

  void _onPayPressed() async {
    DioClient client = DioClient();
    int? statusCode = await client.buy();
    if (statusCode == 200) {
      setState(() => showToast(context,
          'Payment Status: Successful\nThe download link of the high quality picture hs been sent to your email address.'));
      widget.cart.changeStatus('Paid');
      widget.cart = Cart();
    } else if (statusCode == 401) {
      setState(() => showToast(context, 'Session ended. Please login again.'));
      Navigator.of(context).pushNamed('/logIn');
    } else {
      setState(() =>
          showToast(context, 'Paying process was not successful. Try again!'));
    }
  }

  void onDelete(PictureModel pic) async {
    if (widget.cart.getId() != null) {
      DioClient client = DioClient();
      if (await client.removeFromCart(
              widget.cart.getId(), int.parse(pic.name)) !=
          200) {
        setState(() => showToast(context, 'Couldn\'t delete this item'));
      }
    }
    setState(() => widget.cart.removeFromCart(pic));
  }

  void _onHomePressed() => Navigator.of(context).pushNamed('/main_page');
}
