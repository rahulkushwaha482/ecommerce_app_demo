import 'package:ecommerce_demo_app/store/cart_store/cart_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../service/service_locator.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartStore cartStore = locator<CartStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart items'),
        centerTitle: false,
      ),
      body: Observer(
        builder: (_) {
          if (cartStore.products.isNotEmpty) {
            return ListView.builder(
                itemCount: cartStore.products.length,
                itemBuilder: (context, index) {
                  final cartItem = cartStore.products[index];

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(8.0),
                          child: Image.network(
                            cartItem.productImages!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem.title.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Rs ${cartItem.mrp}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                // Quantity Selector
                              ],
                            ),
                          ),
                        ),
                        // Delete Button
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () {
                              cartStore.removeProductData(cartItem);
                              // context
                              //     .read<CartProvider>()
                              //     .removeCartItem(cartItem);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: Text('Cart is empty'),
            );
          }
        },
      ),
    );
  }
}
