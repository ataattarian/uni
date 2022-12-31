// ignore_for_file: non_constant_identifier_names

import 'package:photo_shop/models/cart.dart';
import 'package:photo_shop/models/user.dart';

class CurrentData {
  static User user = User();
  static Cart cart= Cart();

  static bool isLoggedIn() {
    return user.access != null;
  }
}
