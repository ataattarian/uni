import 'package:flutter/material.dart';
import 'package:photo_shop/models/category.dart';
import 'package:photo_shop/util/api/dio_client.dart';
import 'package:photo_shop/util/constants/colors_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> _categories= [];

  getCats() async {
    DioClient client = DioClient();
     _categories = await client.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCats(),
      builder: (context, AsyncSnapshot snapshot) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorsList.darkBeige.withOpacity(0.5),
          elevation: 1.0,
          toolbarHeight: 80.0,
          title: const Text("Category",
            style: TextStyle(
                color: ColorsList.cyan,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
        backgroundColor: ColorsList.beige,
        body: SingleChildScrollView(
          child: GridView(
              padding: const EdgeInsets.all(20.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 3/1
              ),
              children: List.generate(
                _categories.length,
                    (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => _onTap(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorsList.darkBeige,
                      ),
                      padding: const  EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text(_categories[index].name,
                        style: const TextStyle(
                            color: ColorsList.shadow,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ))
        ),
      ),
    );
  }

  _onTap() {
    //no api
  }
}
