
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_list_reponse_dto.dart';

final productListProvider = StateNotifierProvider<ProductListNotifier,ProductListState>((ref){
  return ProductListNotifier();
});

class ProductListState{
  final AsyncValue<ProductListResponseDto> products;

  ProductListState({required this.products});

  ProductListState copyWith({
    AsyncValue<ProductListResponseDto>? products,
  }) {
    return ProductListState(
      products: products ?? this.products,
    );
  }
}

class ProductListNotifier extends StateNotifier<ProductListState>{
 ProductListNotifier():super(ProductListState(products: const AsyncLoading())){
   getProducts();
 }

 Future<void> getProducts() async{
   try{
     String jsonContent = await rootBundle.loadString("assets/product_list.json");
     Map<String, dynamic> productData = json.decode(jsonContent);
     final productListResponse = ProductListResponseDto.fromJson(productData);
     state = state.copyWith(products: AsyncValue.data(productListResponse));
     state = state.copyWith(products: AsyncValue.data(productListResponse));

     print(productListResponse.toJson());
     print('state.products.value!.products');
   }catch (e){
     state = state.copyWith(products: AsyncValue.error(e,StackTrace.empty));
   }
 }

}