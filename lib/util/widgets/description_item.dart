import 'package:flutter/material.dart';

class DescriptionItem extends StatelessWidget {
  final String title;
  final String description;

  const DescriptionItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("$title: ",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        Text(description,style: const TextStyle(fontSize: 20),),
      ],
    );
  }
}
