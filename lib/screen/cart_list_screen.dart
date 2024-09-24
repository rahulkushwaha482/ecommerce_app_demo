import 'package:ecommerce_demo_app/bloc/cart_list_bloc/cart_list_bloc.dart';
import 'package:ecommerce_demo_app/bloc/cart_list_bloc/cart_list_event.dart';
import 'package:ecommerce_demo_app/bloc/cart_list_bloc/cart_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartListScreen extends StatelessWidget {
  const CartListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartListBloc>().add(GetCartItemEvent());

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Product List'),
      ),
      body: BlocBuilder<CartListBloc,CartListState>(
        builder: (context,state) {
          if(state is CartFinalState) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final cartItem = state.data[index];

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

                            context.read<CartListBloc>().add(RemoveItemFromCartEvent(cartItem));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }else{
            return const Center(child: Text('Cart is empty'));
          }

        }
      ),
    );
  }
}
