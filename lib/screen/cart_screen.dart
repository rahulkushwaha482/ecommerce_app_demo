import 'package:ecommerce_demo_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: false,
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          if (provider.proDuctData.isEmpty) {
            return Center(
              child: Text('Cart item is empty'),
            );
          } else {
            return ListView.builder(
                itemCount: provider.proDuctData.length,
                itemBuilder: (context, index) {
                  final cartItem = provider.proDuctData[index];

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
                              context
                                  .read<CartProvider>()
                                  .removeCartItem(cartItem);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
