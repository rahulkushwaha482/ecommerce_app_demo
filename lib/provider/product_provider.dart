
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/product_model.dart';

class ProductProvider with ChangeNotifier{
  List<Products> productData = [];

  Future<void> getProductItems()async{
    String roortData = await rootBundle.loadString('assets/product.json');
    Map<String,dynamic> data = json.decode(roortData);
    var listData = ProductListResponseDto.fromJson(data);
    productData = listData.products!;
    notifyListeners();
  }

}