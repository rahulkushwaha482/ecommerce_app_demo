import 'package:ecommerce_demo_app/controller/cart_controller.dart';
import 'package:ecommerce_demo_app/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: false,
        actions:  [
    Obx(() {return  GestureDetector(
            onTap: (){
              Get.toNamed('/cart');
            },
            child: Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: badges.Badge(
                  showBadge: cartController.cartItems.isNotEmpty,
                  badgeContent: Text(
                    cartController.cartItems.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  badgeAnimation: badges.BadgeAnimation.rotation(
                    animationDuration: Duration(seconds: 1),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),child: Icon(Icons.shopping_cart)),
            ),
          );}),
        ],
      ),
      body:  Obx(() {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 4,
            ),
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];
              return Card(
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                        product.productImages!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.title!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '\u{20B9}${product.mrp}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){

                            cartController.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.title} added to cart!'),
                                backgroundColor: Colors.lightGreen,
                              ),
                            );
                          },
                          child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                              child: Icon(Icons.add_shopping_cart)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );

      }),
    );
  }
}