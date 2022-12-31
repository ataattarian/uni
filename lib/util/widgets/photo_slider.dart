import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_shop/models/picture_model.dart';
import 'package:photo_shop/screens/mainpage/photo_popup.dart';
import 'package:photo_shop/util/constants/colors_list.dart';

class PhotoSlider extends StatefulWidget {
  final List<PictureModel> pictures;

  const PhotoSlider({super.key, required this.pictures});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<PhotoSlider> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: List.generate(
            widget.pictures.length,
            (index) => GestureDetector(
              onTap: () => _onTap(widget.pictures[index]),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.pictures[index].image),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 4 / 1,
              onPageChanged: (index, reason) =>
                  setState(() => _current = index)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.pictures.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == entry.key
                        ? ColorsList.cyan
                        : ColorsList.shadow.withOpacity(0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _onTap(PictureModel picture) {
    showDialog(
        context: context, builder: (context) => PhotoPopUp(photo: picture));
  }
}
