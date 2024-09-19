import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final bool isAdded;


  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.isAdded,
  });

  CartItem copyWith({bool? isAdded}) {
    return CartItem(
      id: id,
      name: name,
      imageUrl: imageUrl,
      price: price,
      isAdded: isAdded??this.isAdded,
    );
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(CartItem item) {
    final index = state.indexWhere((cartItem) => cartItem.id == item.id);

    if (index >= 0) {
    } else {
      // If the item doesn't exist, add it to the cart
      state = [...state, item.copyWith(isAdded: true)];
    }
  }

  void removeFromCart(String id, ) {
    // Remove item by ID and optionally by quantity if specified
    state = state.where((item) {

      return item.id != id;
    }).toList();
  }
}