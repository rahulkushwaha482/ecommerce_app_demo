import 'package:ecommerce_demo_app/screen/cart_screen.dart';
import 'package:ecommerce_demo_app/state/cart_state.dart';
import 'package:ecommerce_demo_app/state/product_state.dart';
import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:badges/badges.dart' as badges;

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var state = June.getState(() => CartState());


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
                  badgeContent: JuneBuilder(()=>CartState(), builder: (state){
                    return Text(
                      state.products.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    );
                  }),

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
      body: JuneBuilder(
        () => ProductState(),
        builder: (data) {
          return GridView.builder(
              itemCount: data.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = data.products[index];
                return Card(
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          productData.productImages!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          productData.title!,
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
                              '\u{20B9}${productData.mrp}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              state.addToCartItem(productData);
                              // context
                              //     .read<CartProvider>().addToCartItem(data);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${productData.title} added to cart!'),
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
      ),
    );
  }
}
