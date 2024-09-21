import 'package:ecommerce_demo_app/controller/cart_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: false,
      ),
      body: Obx(() {
        return controller.cartItems.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: ListView.builder(
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = controller.cartItems[index];
                          if (kDebugMode) {
                            print(
                              cartItem.productImages.toString(),
                            );
                          }
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      controller.removeFromCart(cartItem);
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total amount: Rs ${controller.totalPrice}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              textStyle: const TextStyle(
                                  fontSize: 18, color: Colors.red),
                              backgroundColor: Colors.amber,
                            ),
                            child: const Text('Proceed to Payment'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text('Your Cart Items are empty!!'),
              );
      }),
    );
  }
}
