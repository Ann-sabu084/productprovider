// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cartpage.dart';
import 'package:flutter_application_1/cartprovider.dart';
import 'package:flutter_application_1/productpage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:ProductPage() );
  }
}