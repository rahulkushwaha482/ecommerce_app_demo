import 'dart:convert';
import 'package:ecommerce_demo_app/bloc/product_list_bloc/product_list_event.dart';
import 'package:ecommerce_demo_app/bloc/product_list_bloc/product_list_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/product_model.dart';

class ProductListBloc extends Bloc<ProductListEvent,ProductListState>{
  ProductListBloc():super(ProductListInitialState()){

    on<GetProductEvent>((event,emit) async {
      emit(ProductListLoadingState());  // Emit loading state

      try {
        // Load and decode JSON data
        String jsonData = await rootBundle.loadString('assets/product.json');
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        var data = ProductListResponseDto.fromJson(jsonDataMap);

        emit(ProductListFinalState(data.products ?? []));
      } catch (e) {
        // Emit error state if there's an issue
        emit(ProductListErrorState("Error loading products: ${e.toString()}"));
      }
    });



  }

}