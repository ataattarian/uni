// ignore_for_file: non_constant_identifier_names

import 'package:photo_shop/models/category.dart';

class PictureModel {
  int? id;
  String name;
  Category category;
  String description;
  String dimensions;
  String size;
  double price;
  String image;
  String? real_image;

  PictureModel(
    this.id,
    this.name,
    this.category,
    this.description,
    this.dimensions,
    this.size,
    this.price,
    this.image,
    this.real_image,
  );

  factory PictureModel.fromJson(Map<String, dynamic> json) => PictureModel(
        null,
        json['name'],
        Category.fromJson(json['category']),
        json['description'],
        json['dimensions'],
        json['size'],
        double.parse(json['price']),
        json['image'],
        null,
      );

  factory PictureModel.fromJsonCarts(Map<String, dynamic> json) => PictureModel(
        json['id'],
        json['name'],
        Category.fromJson(json['category']),
        json['description'],
        json['dimensions'],
        json['size'],
        double.parse(json['price']),
        json['image'],
        null,
      );
}
