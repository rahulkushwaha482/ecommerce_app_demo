import 'package:ecommerce_demo_app/bloc/cart_list_bloc/cart_list_bloc.dart';
import 'package:ecommerce_demo_app/bloc/product_list_bloc/product_list_bloc.dart';
import 'package:ecommerce_demo_app/screen/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => CartListBloc()),
        BlocProvider(create: (BuildContext context) => ProductListBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ProductListScreen(),
      ),
    );
  }
}
