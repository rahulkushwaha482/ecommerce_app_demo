// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductStore on _ProductStore, Store {
  late final _$productsAtom =
      Atom(name: '_ProductStore.products', context: context);

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

  late final _$getProductDataAsyncAction =
      AsyncAction('_ProductStore.getProductData', context: context);

  @override
  Future<void> getProductData() {
    return _$getProductDataAsyncAction.run(() => super.getProductData());
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
