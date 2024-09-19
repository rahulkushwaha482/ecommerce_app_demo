import 'package:ecommerce_demo_app/provider/cart_item_provider.dart';
import 'package:ecommerce_demo_app/provider/product_list_provider.dart';
import 'package:ecommerce_demo_app/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the productListProvider to get the current state
    final productListState = ref.watch(productListProvider);
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  CartScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: badges.Badge(
                showBadge: cartItems.isNotEmpty,
                badgeContent: Text(
                  cartItems.length.toString(),
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
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  shadows: <Shadow>[
                    Shadow(
                        color: Colors.black, blurRadius: 2.0)
                  ],
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: productListState.products.when(
        data: (productListResponse) {
          // Extract the list of products from the response
          final products = productListResponse.products; // Assuming 'products' is a list of Product objects

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 3 / 4,
            ),
            itemCount: products?.length,
            itemBuilder: (context, index) {
              final product = products?[index];
              return Card(
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                        product!.productImages.toString(), // Assuming you have an imageUrl property
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.title.toString(),
                        maxLines: 2,// Assuming you have a name property
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '\u{20B9}${product.mrp}', // Assuming you have a price property
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){

                            ref.read(cartProvider.notifier).addToCart(
                              CartItem(
                                id: product.id.toString(),
                                name: product.title.toString(),
                                imageUrl:
                                product.productImages!.toString(),
                                price: product.mrp.toString(),
                                isAdded: true,
                              ),
                            );
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
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const Center(child: Text('Error loading products')),
      ),
    );
  }
}
