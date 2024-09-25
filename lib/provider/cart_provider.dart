import 'package:ecommerce_demo_app/model/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Products> proDuctData = [];

  Future<void> addToCartItem(Products item) async {
    final index = proDuctData.indexWhere((cartItem) => cartItem.id == item.id);
    if (index >= 0) {
    } else {
      proDuctData.add(item);
    }
    notifyListeners();
  }

  Future<void> getCartItems() async{
    proDuctData.toList();
    notifyListeners();
  }

  Future<void> removeCartItem(Products item) async{
    int index = proDuctData.indexWhere((cartItem) =>cartItem.id == item.id);
    if(index != -1){
      proDuctData.removeAt(index);
      if(proDuctData.isEmpty){
        notifyListeners();
      }
    }
    notifyListeners();

  }
}
