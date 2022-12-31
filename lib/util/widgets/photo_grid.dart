import 'package:flutter/material.dart';
import 'package:photo_shop/models/picture_model.dart';
import 'package:photo_shop/screens/mainpage/photo_popup.dart';

class PhotoGrid extends StatefulWidget {
  final List<PictureModel> pictures;

  const PhotoGrid({required this.pictures, Key? key}) : super(key: key);

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(20.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2/1
        ),
        children: List.generate(
          widget.pictures.length,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _onTap(widget.pictures[index]),
              child: Image.network(
                widget.pictures[index].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
  }

  void _onTap(PictureModel picture) {
    showDialog(
        context: context, builder: (context) => PhotoPopUp(photo: picture));
  }
}
