
import 'package:ecommerce_demo_app/store/cart_store/cart_store.dart';
import 'package:ecommerce_demo_app/store/product_strore/product_store.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ProductStore());
  locator.registerLazySingleton(() => CartStore());
}
