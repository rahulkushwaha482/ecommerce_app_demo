import 'package:ecommerce_demo_app/provider/product_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the productListProvider to get the current state
    final productListState = ref.watch(productListProvider);

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
              // Your cart action here
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: Icon(Icons.shopping_cart),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                          child: Icon(Icons.add_shopping_cart)
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
