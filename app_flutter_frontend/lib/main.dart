import 'package:flutter/material.dart';
import 'package:products_app/screens/products.dart';
import 'package:products_app/services/base_service.dart';
import 'package:products_app/services/products_service.dart';
import 'package:products_app/utils/constants.dart';
import 'package:products_app/utils/theme.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: appTheme,
      home: ProductsPage(
        baseService: const BaseService(), 
        productsService: const ProductsService(baseService: BaseService()),
      ),
    );
  }
}