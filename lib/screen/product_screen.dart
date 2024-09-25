import 'package:ecommerce_demo_app/screen/cart_screen.dart';
import 'package:ecommerce_demo_app/store/cart_store/cart_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:badges/badges.dart' as badges;
import '../service/service_locator.dart';
import '../store/product_strore/product_store.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductStore productStore = locator<ProductStore>();
    productStore.getProductData();
    final CartStore cartStore = locator<CartStore>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: badges.Badge(
                    showBadge: true,
                    badgeContent: Observer(
                      builder: (_){
                        return Text(
                          cartStore.products.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        );
                      }

                    ),
                    badgeAnimation: const badges.BadgeAnimation.rotation(
                      animationDuration: Duration(seconds: 1),
                      colorChangeAnimationDuration: Duration(seconds: 1),
                      loopAnimation: false,
                      curve: Curves.fastOutSlowIn,
                      colorChangeAnimationCurve: Curves.easeInCubic,
                    ),
                    child: const Icon(Icons.shopping_cart)),
              ),
            )
          ],
        ),
        body: Observer(builder: (_) {
          return GridView.builder(
              itemCount: productStore.products.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                final data = productStore.products[index];
                return Card(
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          data.productImages!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data.title!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '\u{20B9}${data.mrp}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cartStore.addProductData(data);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${data.title} added to cart!'),
                                  backgroundColor: Colors.lightGreen,
                                ),
                              );
                            },
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 5),
                                child: Icon(Icons.add_shopping_cart)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        }));
  }
}
