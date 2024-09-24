import 'package:ecommerce_demo_app/model/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductListEvent  extends Equatable{
  @override
  List<Object?> get props => [];
}

// class AddProductEvent extends ProductListEvent {
//   Products item;
//
//   AddProductEvent(this.item);
//   @override
//   List<Object?> get props => [item];
// }

class GetProductEvent extends ProductListEvent{
  @override
  List<Object?> get props => [];
}
