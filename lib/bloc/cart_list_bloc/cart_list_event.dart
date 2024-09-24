
import 'package:equatable/equatable.dart';

import '../../model/product_model.dart';

abstract class CartListEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class AddItemToCartEvent extends CartListEvent{
  Products item;
  AddItemToCartEvent(this.item);
  @override
  List<Object?> get props => [item];
}

class GetCartItemEvent extends CartListEvent{
  @override
  List<Object?> get props => [];
}

class RemoveItemFromCartEvent extends CartListEvent{
  Products item;
  RemoveItemFromCartEvent(this.item);

  @override
  List<Object?> get props => [item];
}
