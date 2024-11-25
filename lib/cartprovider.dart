// cart_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cart = [];

  List<CartItem> get cart => _cart;

  // Add a product to the cart
  void addToCart(Product product) {
    final existingItem = _cart.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      _cart.add(CartItem(product: product, quantity: 1)); // Add with quantity 1
    } else {
      existingItem.quantity++; // Increment quantity
    }

    notifyListeners();
  }

  // Remove a product from the cart
  void removeFromCart(Product product) {
    _cart.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  // Increment quantity of a cart item
  void incrementQuantity(CartItem cartItem) {
    cartItem.quantity++;
    notifyListeners();
  }

  // Decrement quantity of a cart item
  void decrementQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    }
    notifyListeners();
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
