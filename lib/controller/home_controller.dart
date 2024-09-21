import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../model/product_list_model.dart';

class HomeController extends GetxController {
  var productList = <Products>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    String data = await rootBundle.loadString('assets/product.json');
    Map<String, dynamic> productData = json.decode(data);
    final productListResponse = ProductListResponseDto.fromJson(productData);
    productList.value = productListResponse.products!;
  }
}
