import 'dart:convert';

import 'package:ecommerce_demo_app/model/product_model.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';


part 'product_store.g.dart'; // For code generation

class ProductStore = _ProductStore with _$ProductStore;

abstract class _ProductStore with Store{
  @observable
  ObservableList<Products> products = ObservableList<Products>();

  @action
  Future<void> getProductData() async{
    try {
      // Load product data from assets
      String dataRoot = await rootBundle.loadString('assets/product.json');

      // Parse the JSON data
      Map<String, dynamic> data = json.decode(dataRoot);

      // Convert the JSON into your DTO object
      final dataJson = ProductListResponseDto.fromJson(data);

      // Assign the product list to the observable list
      products = ObservableList<Products>.of(dataJson.products??[]);
    } catch (e) {
      print("Error loading product data: $e");
    }
  }

}