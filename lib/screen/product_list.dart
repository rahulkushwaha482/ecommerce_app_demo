import 'package:ecommerce_demo_app/bloc/cart_list_bloc/cart_list_bloc.dart';
import 'package:ecommerce_demo_app/bloc/cart_list_bloc/cart_list_event.dart';
import 'package:ecommerce_demo_app/bloc/cart_list_bloc/cart_list_state.dart';
import 'package:ecommerce_demo_app/bloc/product_list_bloc/product_list_bloc.dart';
import 'package:ecommerce_demo_app/bloc/product_list_bloc/product_list_state.dart';
import 'package:ecommerce_demo_app/screen/cart_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import '../bloc/product_list_bloc/product_list_event.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductListBloc>().add(GetProductEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        centerTitle: false,
        actions: [
          BlocListener<CartListBloc, CartListState>(
            listener: (context, state) {
              print(state);

            },
            child: BlocBuilder<CartListBloc, CartListState>(
                builder: (context, state) {
              final cartItemCount =
                  state is CartFinalState ? state.data.length : 0;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartListScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: badges.Badge(
                      showBadge: true,
                      badgeContent: Text(
                        cartItemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
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
              );
            }),
          ),
        ],
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          print(state);
          if (state is ProductListFinalState) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                final data = state.data[index];
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
                                  .read<CartListBloc>()
                                  .add(AddItemToCartEvent(data));

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
              },
              itemCount: state.data.length,
            );
          } else if (state is ProductListLoadingState) {
            // Show loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductListErrorState) {
            // Show error message
            return Center(child: Text(state.message));
          } else {
            // Initial or other unknown states
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
