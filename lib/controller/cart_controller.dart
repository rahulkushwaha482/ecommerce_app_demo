import 'package:ecommerce_demo_app/model/product_list_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Products>[].obs;

  void addToCart(Products item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (index >= 0) {
    } else {
      cartItems.add(item);
    }
  }

  void removeFromCart(Products item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (index != -1) {
      cartItems.removeAt(index);
    }
  }

  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.mrp!.toInt()));
  }
}
