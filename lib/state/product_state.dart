import 'dart:convert';

import 'package:ecommerce_demo_app/model/product_model.dart';
import 'package:flutter/services.dart';
import 'package:june/june.dart';


class ProductState extends JuneState{


  List<Products> products = [];

  @override
  void onInit(){
    super.onInit();
   getProducts();

  }

  Future<void> getProducts()async{
    String jsonString  = await rootBundle.loadString('assets/product.json');
    Map<String,dynamic> data = json.decode(jsonString);
    final dataNew = ProductListResponseDto.fromJson(data);
    products = dataNew.products!;
  }

}