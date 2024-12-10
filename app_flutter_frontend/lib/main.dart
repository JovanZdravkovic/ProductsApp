import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(const MyApp());
}

class Product {
  final String productName;
  final String productManufacturer;
  final bool warranty;
  final String productManufacturingDate;

  const Product({
    required this.productName,
    required this.productManufacturer,
    required this.warranty,
    required this.productManufacturingDate
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // fix to readable later
    return switch (json) {
      {
        'productName': String productName,
        'productManufacturer': String productManufacturer,
        'warranty': bool warranty,
        'productManufacturingDate': String productManufacturingDate,
      } =>
        Product(
          productName: productName,
          productManufacturer: productManufacturer,
          warranty: warranty,
          productManufacturingDate: productManufacturingDate,
        ),
      _ => throw const FormatException('Failed to load a product.'),
    };
  }
}

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8080/products'));
  if(response.statusCode == 200) {
    var productObjJson = jsonDecode(response.body) as List;
    List<Product> productsList = productObjJson.map((productJson) => Product.fromJson(productJson)).toList();
    return productsList;
  } else {
    throw Exception('Failed to load products');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Future<List<Product>> futureProductsList;

  @override
  void initState() {
    super.initState();
    futureProductsList = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 21, 175, 241)),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: Center(
          child: FutureBuilder<List<Product>>(
            future: futureProductsList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    for(var product in snapshot.data!)
                      BigCard(p: product),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        )
      ),
    );
  }
}

class BigCard extends StatelessWidget {

  const BigCard({super.key, required this.p});

  final Product p;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${p.productName}', style: style),
            Text('Manufacturer: ${p.productManufacturer}', style: style),
            Text('Warranty: ${p.warranty}', style: style),
            Text('Manufactured date: ${p.productManufacturingDate}', style: style),
          ],
        ) ,
      ), 
    );
  }
}
