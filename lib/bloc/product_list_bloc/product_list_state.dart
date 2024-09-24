
import 'package:ecommerce_demo_app/model/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductListState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ProductListLoadingState extends ProductListState {
  @override
  List<Object?> get props => [];
}

class ProductListInitialState extends ProductListState{
  @override
  List<Object?> get props => [];
}

class ProductListFinalState extends ProductListState{
  List<Products> data ;
  ProductListFinalState(this.data);

  @override
  List<Object?> get props => [data];
}

class ProductListErrorState extends ProductListState {
  final String message;

  ProductListErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
