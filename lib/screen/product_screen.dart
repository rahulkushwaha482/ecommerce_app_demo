import 'package:ecommerce_demo_app/provider/cart_provider.dart';
import 'package:ecommerce_demo_app/provider/product_provider.dart';
import 'package:ecommerce_demo_app/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getProductItems();
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
                    badgeContent:
                        Consumer<CartProvider>(builder: (context, cart, child) {
                      return Text(
                        cart.proDuctData.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      );
                    }
                    ,child: Text(''),),


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
        body: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            return GridView.builder(
                itemCount: provider.productData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final data = provider.productData[index];
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
                                context
                                    .read<CartProvider>().addToCartItem(data);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('${data.title} added to cart!'),
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
          },
        ));
  }
}
