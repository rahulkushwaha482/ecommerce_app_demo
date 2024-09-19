import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/cart_item_provider.dart';


class CartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the cart items from the provider
    final cartItems = ref.watch(cartProvider);

    // Calculate the total number of items and the total amount
    final totalAmount = cartItems.fold(0.0, (sum, item) {
      return sum + (double.parse(item.price) );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: false,
      ),
      body: cartItems.isNotEmpty? Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  print(
                    cartItem.imageUrl.toString(),
                  );
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        // Product Image
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(8.0),
                          child: Image.network(
                            cartItem.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Product Details
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Rs ${cartItem.price}',
                                  style: TextStyle(
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
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () {
                              ref.read(cartProvider.notifier).removeFromCart(
                                cartItem.id,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Total Items and Amount
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total amount: Rs $totalAmount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                // Proceed to Payment Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the payment process
                    },
                    child: Text('Proceed to Payment'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      textStyle: TextStyle(fontSize: 18,color: Colors.red),
                      backgroundColor: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ):Center(child: Text('Your Cart Items are empty!!'),)
    );
  }
}