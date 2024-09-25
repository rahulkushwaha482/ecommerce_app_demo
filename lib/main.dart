import 'package:ecommerce_demo_app/provider/cart_provider.dart';
import 'package:ecommerce_demo_app/provider/product_provider.dart';
import 'package:ecommerce_demo_app/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // For multiple Provider muse MultiProvider with ChangeNotifiersProvider
    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (context)=>ProductProvider()),
       ChangeNotifierProvider(create: (context)=>CartProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ProductScreen(),
      ),
    );
  }
}

