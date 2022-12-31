// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:photo_shop/models/cart.dart';
import 'package:photo_shop/models/category.dart';
import 'package:photo_shop/models/picture_model.dart';
import 'package:photo_shop/util/constants/current_data.dart';

class DioClient {
  final Dio _dio = Dio();
  // final _baseUrl = 'http://65.108.158.161:1337';
  final _baseUrl = 'https://api.tempservice.ir';
  final _options = Options(headers: {
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*"
  });

  Future<int?> login(
      {required String username, required String password}) async {
    print("1");
    try {
      print("2");
      Response response = await _dio.post('$_baseUrl/user/login/',
          data: {'username': username, 'password': password},
          options: _options).timeout(const Duration(seconds: 15));
      CurrentData.user.fromJsonLogin(
          json: response.data, username: username, password: password);
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.message);
        print('Dio error!');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return -1;
  }

  Future<int?> register() async {
    try {
      Response response = await _dio.post('$_baseUrl/user/register/',
          data: CurrentData.user.toJson(), options: _options).timeout(const Duration(seconds: 15));
      CurrentData.user.fromJsonSignup(response.data);
      print(response.statusCode);
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.message);
        print('Dio error!');
      } else {
        print('Error sending request!');
      }
    }
    return -1;
  }

  Future<int?> buy() async {
    try {
      _dio.options.headers["Authorization"] =
          "Bearer ${CurrentData.user.access}";
      Response response = await _dio
          .post('$_baseUrl/buy/', data: {'ids': CurrentData.cart.getIds()}).timeout(const Duration(seconds: 15));
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        print('Dio error!');
        return e.response?.statusCode;
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return -1;
  }

  Future<List<PictureModel>> getPics() async {
    try {
      Response response =
          await _dio.get('$_baseUrl/pictures/', options: _options).timeout(const Duration(seconds: 15));
      List<PictureModel> pics = List.from(response.data)
          .map((e) => PictureModel.fromJson(e))
          .toList();
      return pics;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        print('Dio error!');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return [];
  }

  Future<List<Category>> getCategories() async {
    try {
      Response response =
      await _dio.get('$_baseUrl/category/', options: _options).timeout(const Duration(seconds: 15));
      List<Category> cats = List.from(response.data)
          .map((e) => Category.fromJson(e))
          .toList();
      return cats;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        print('Dio error!');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return [];
  }

  Future<List<Cart>> getCarts() async {
    try {
      _dio.options.headers["Authorization"] =
          "Bearer ${CurrentData.user.access}";
      Response response = await _dio.get('$_baseUrl/cart/', options: _options).timeout(const Duration(seconds: 15));
      final List<Cart> carts = List.from(response.data).map((e) {
        Cart cart = Cart();
        cart.fromJson(e);
        return cart;
      }).toList();
      return carts;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        print('Dio error!');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return [];
  }

  Future<int?> removeFromCart(int? index, int item) async {
    try {
      _dio.options.headers["Authorization"] =
          "Bearer ${CurrentData.user.access}";
      Response response =
          await _dio.put('$_baseUrl/cart/$index/', options: _options, data: {
        'ids': [item]
      }).timeout(const Duration(seconds: 15));
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        print('Dio error!');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return -1;
  }
}
