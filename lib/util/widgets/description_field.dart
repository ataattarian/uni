import 'package:flutter/material.dart';
import 'package:photo_shop/models/picture_model.dart';
import 'package:photo_shop/util/widgets/description_item.dart';

class DescriptionField extends StatelessWidget {
  final PictureModel photo;
  const DescriptionField({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DescriptionItem(
            title: "Name",
            description: photo.name),
        DescriptionItem(
            title: "Description",
            description: photo.description),DescriptionItem(
            title: "Dimensions",
            description: photo.dimensions),
        DescriptionItem(
            title: "Size",
            description:photo.size),
        DescriptionItem(
            title: "Price",
            description: photo.price.toString()),
      ],
    );
  }
}
