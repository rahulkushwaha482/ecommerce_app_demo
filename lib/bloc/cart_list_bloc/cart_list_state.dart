import 'package:equatable/equatable.dart';
import '../../model/product_model.dart';

abstract class CartListState extends Equatable{
  @override
  List<Object?> get props => [];
}

class CartEmptyState extends CartListState{
  @override
  List<Object?> get props => [];
}

class CartFinalState extends CartListState{
  List<Products> data ;
  CartFinalState(this.data);

  @override
  List<Object?> get props => [data];
}