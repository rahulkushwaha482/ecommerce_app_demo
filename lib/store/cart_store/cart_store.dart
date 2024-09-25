import 'package:mobx/mobx.dart';

import '../../model/product_model.dart';
part 'cart_store.g.dart'; // For code generation

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  @observable
  ObservableList<Products> products = ObservableList<Products>();

  @action
  Future<void> addProductData(Products product) async {
    int index = products.indexWhere((cartItem) => cartItem.id == product.id);

    if (index >= 0) {
    } else {
      products.add(product);
    }
  }

  @action
  Future<void> removeProductData(Products prduct) async {
    int index = products.indexWhere((cartItem) => cartItem.id == prduct.id);

    if (index != -1) {
      products.removeAt(index);
      if (products.isEmpty) {}
    }
  }
}
