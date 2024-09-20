
import 'package:ecommerce_demo_app/model/product_list_model.dart';
import 'package:get/get.dart';


class CartController extends GetxController {
  // Cart items will be stored in an observable list
  var cartItems = <Products>[].obs;

  // Method to add an item to the cart
  void addToCart(Products item) {
    // Check if the item already exists in the cart
    int index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (index >= 0) {
    } else {
      // If the item is not in the cart, add it
      cartItems.add(item);
      print(cartItems.length);
    }
  }

  // Method to remove an item from the cart
  void removeFromCart(Products item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    print(index);

    if (index != -1) {
      cartItems.removeAt(index);
    }

  }

  // Method to get the total price of items in the cart
  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.mrp!.toInt() ));
  }

}
