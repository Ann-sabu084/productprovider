// cart_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cartprovider.dart';

import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cart = cartProvider.cart;

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: cart.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (ctx, index) {
                final cartItem = cart[index];
                return ListTile(
                  leading: Image.network(cartItem.product.image, width: 50, height: 50),
                  title: Text(cartItem.product.title),
                  subtitle: Text('\$${cartItem.product.price} x ${cartItem.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          cartProvider.decrementQuantity(cartItem);
                        },
                      ),
                      Text(cartItem.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          cartProvider.incrementQuantity(cartItem);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          cartProvider.removeFromCart(cartItem.product);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
