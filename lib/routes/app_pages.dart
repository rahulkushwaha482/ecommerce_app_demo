
import 'package:ecommerce_demo_app/screen/cart_screen.dart';
import 'package:ecommerce_demo_app/screen/home_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages{
  static final pages = [
    GetPage(name: '/home', page: () =>  const HomePage(),),
    GetPage(name: '/cart', page: () =>   CartScreen(),),
  ];
}