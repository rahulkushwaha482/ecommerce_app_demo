// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on _CartStore, Store {
  late final _$productsAtom =
      Atom(name: '_CartStore.products', context: context);

  @override
  ObservableList<Products> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<Products> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$addProductDataAsyncAction =
      AsyncAction('_CartStore.addProductData', context: context);

  @override
  Future<void> addProductData(Products product) {
    return _$addProductDataAsyncAction.run(() => super.addProductData(product));
  }

  late final _$removeProductDataAsyncAction =
      AsyncAction('_CartStore.removeProductData', context: context);

  @override
  Future<void> removeProductData(Products prduct) {
    return _$removeProductDataAsyncAction
        .run(() => super.removeProductData(prduct));
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
