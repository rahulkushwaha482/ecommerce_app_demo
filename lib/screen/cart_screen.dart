import 'package:flutter/material.dart';
import 'package:june/june.dart';

import '../state/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          centerTitle: false,
        ),
        body: JuneBuilder(
          () => CartState(),
          builder: (state) {
            print(state.products.length);
            if (state.products.isNotEmpty) {
              return ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final cartItem = state.products[index];
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
                                state.removeCartItem(cartItem);
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
        ));
  }
}
