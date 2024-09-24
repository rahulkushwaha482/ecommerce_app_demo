import 'package:ecommerce_demo_app/bloc/cart_list_bloc/cart_list_event.dart';
import 'package:ecommerce_demo_app/bloc/cart_list_bloc/cart_list_state.dart';
import 'package:ecommerce_demo_app/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  CartListBloc() : super(CartEmptyState()) {
    List<Products> products = [];

    on<AddItemToCartEvent>((event, emit) async {
      int index =
          products.indexWhere((cartItem) => cartItem.id == event.item.id);

      if (index >= 0) {
      } else {
        products.add(event.item);
        emit(CartFinalState(List.from(products)));
      }
    });

    on<GetCartItemEvent>((event, emit) async {
      if (products.isEmpty) {
        emit(CartEmptyState());
      } else {
        // We can use toList or List.from to create a new reference of previous
        // list
        emit(CartFinalState(products.toList()));
      }
    });

    on<RemoveItemFromCartEvent>((event, emit) async {
      int index =
          products.indexWhere((cartItem) => cartItem.id == event.item.id);
      if (index != -1) {
        products.removeAt(index);
        if (products.isEmpty) {
          emit(CartEmptyState()); // Emit a state to handle empty cart scenario
        } else {
          emit(CartFinalState(List.from(products))); // Emit updated cart state
        }
      }
    });
  }
}
