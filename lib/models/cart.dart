// ignore_for_file: prefer_final_fields, non_constant_identifier_names

import 'package:photo_shop/models/picture_model.dart';

class Cart {
  int? _id;
  int? _userId;
  double _total_price = 0;
  List<PictureModel> _pictures = [];
  List<int> _ids = [];
  String _status ='Unpaid';
  late DateTime created_at;
  DateTime? updated_at;

  void addToCart(PictureModel new_pic) {
    int id = int.parse(new_pic.name);
    if (!_ids.contains(id)) {
      if (_pictures.isEmpty) {
        created_at = DateTime.now();
        updated_at = DateTime.now();
      } else {
        updated_at = DateTime.now();
      }
      _pictures.add(new_pic);
      _ids.add(id);
      _total_price += new_pic.price;
    }
  }

  void removeFromCart(PictureModel pic) {
    if (_pictures.isNotEmpty && _pictures.contains(pic)) {
      updated_at = DateTime.now();
      _pictures.remove(pic);
      _total_price -= pic.price;
    }
  }

  bool isInCart(PictureModel pic) => _pictures.contains(pic);

  double getTotalPrice() => _total_price;

  void changeStatus(String new_status) => _status = new_status;

  String getStatus() => _status;

  int numberOfCartItems() => _pictures.length;

  PictureModel getPic(int index) => _pictures[index];

  List<int> getIds()=> _ids;
  int? getId()=> _id;

  void fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user'];
    _pictures = List.from(json['pictures'])
        .map((e) => PictureModel.fromJson(e))
        .toList();
  }
}
