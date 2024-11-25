// product_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cartpage.dart';
import 'package:flutter_application_1/cartprovider.dart';
import 'package:flutter_application_1/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    final List<dynamic> productList = json.decode(response.body);

    setState(() {
      _products = productList.map((product) => Product.fromJson(product)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Page')),
      body: _products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: _products.length,
              itemBuilder: (ctx, index) {
                final product = _products[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(product.image, height: 150, fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('\$${product.price}'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add the product to the cart
                          Provider.of<CartProvider>(context, listen: false).addToCart(product);
                        },
                        child: Text('Add to Cart'),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the CartPage
         Navigator.push(context, MaterialPageRoute(builder: (context) {
           return CartPage();
         },));
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
