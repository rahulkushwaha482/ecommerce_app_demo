
import 'package:ecommerce_demo_app/model/product_model.dart';
import 'package:june/june.dart';

class CartState extends JuneState{
  List<Products> products = [];
  //
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   getCartItems();
  // }

  Future<void> addToCartItem(Products product) async{
    int index  =  products.indexWhere((cartItem)=>cartItem.id == product.id);

    if(index ==-1){
      products.add(product);
    }
    setState();
  }

  void removeCartItem(Products productItem){
    int index  =  products.indexWhere((cartItem)=>cartItem.id == productItem.id);
    if(index !=-1){
      products.removeAt(index);
    }
    setState();
  }
}