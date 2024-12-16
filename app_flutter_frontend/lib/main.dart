import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
void main() {
  runApp(const MyApp());
}

class Response {
  final String responseMessage;
  final int statusCode;

  const Response({
    required this.responseMessage,
    required this.statusCode
  });
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

Future<Response> createProduct(String productName, String productManufacturer, DateTime manufacturingDate, bool warranty) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8080/products/create'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'productName': productName,
      'productManufacturer': productManufacturer,
      'warranty': warranty,
      'productManufacturingDate': DateFormat('yyyy-MM-dd').format(manufacturingDate),
    }),
  );
  if(response.statusCode == 200) {
    return Response(responseMessage: 'Successfully created product $productName.', statusCode: 0);
  } else {
    return const Response(responseMessage: 'Error occurred while creating product.', statusCode: 1);
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
    var headlineStyle = Theme.of(context).textTheme.headlineMedium!;

    return MaterialApp(
      title: 'Products app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ProductsPage(headlineStyle: headlineStyle, futureProductsList: futureProductsList),
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({
    super.key,
    required this.headlineStyle,
    required this.futureProductsList,
  });

  final TextStyle headlineStyle;
  final Future<List<Product>> futureProductsList;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  Future<void> navigateCreateProduct(BuildContext context) async {
    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
    final bannerMessage = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => CreateProductPage(headlineStyle: widget.headlineStyle,)),
    );

    if (!context.mounted || bannerMessage == null) {
      return;
    }

    dynamic typeColor;
    // statusCode == 0 ==> Success banner (green)
    // statusCode == 1 ==> Error banner (red)
    // statusCode != 0,1 ==> Info banner (blue)
    switch (bannerMessage.statusCode) {
      case 0:
        typeColor = Colors.green.shade300;
        break; 
      case 1: 
        typeColor = Colors.red.shade600;
        break; 
      default:
        typeColor = Colors.blue;
    }
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      content: Text(bannerMessage.responseMessage, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
      backgroundColor: typeColor,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }, 
          child: Icon(Icons.close, color: Theme.of(context).colorScheme.onPrimary),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {

    const double iconSize = 50.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Products', style: widget.headlineStyle),
      ),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: widget.futureProductsList,
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

            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: SizedBox(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton.large(
            onPressed: () => {
              navigateCreateProduct(context)
            },
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange.shade800,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, size: iconSize),
          ),
        ),
      ),
    );
  }
}

class CreateProductPage extends StatefulWidget {

  const CreateProductPage({super.key, required this.headlineStyle });

  final TextStyle headlineStyle;
  

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final GlobalKey<FormState> _createProductForm = GlobalKey<FormState>();
  String productName = '', productManufacturer = '';
  DateTime? manufacturingDate;
  bool warranty = false;
  late Future<Response> bannerMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final createButtonStyle = theme.textTheme.bodyLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );
    final formTextStyle = theme.textTheme.bodyLarge!;
    const betweenText = 15.0;
    var date = manufacturingDate;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create product', style: widget.headlineStyle),
      ),
      body: Center(
        child: Form(
          key: _createProductForm,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintStyle: formTextStyle,
                    hintText: 'Enter product name',
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      productName = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    }
                    if (value.length > 50) {
                      return 'Product name can\'t be longer than 50 characters.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: betweenText,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintStyle: formTextStyle,
                    hintText: 'Enter manufacturer name',
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      productManufacturer = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter manufacturer name';
                    }
                    if (value.length > 50) {
                      return 'Manufacturer name can\'t be longer than 50 characters.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: betweenText,
                ),
                Row(
                  children: [
                    Text('Warranty: ', style: formTextStyle),
                    Switch(
                      value: warranty,
                      activeColor: theme.colorScheme.primary,
                      onChanged: (bool value) {
                        setState(() {
                          warranty = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: betweenText,
                ),
                Row(
                  children: [
                    Text('Manufacturing date:', style: formTextStyle),
                    const SizedBox(
                      width: betweenText,
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        var pickedDate = await showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDate: DateTime(2024),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2024), 
                        );

                        setState(() {
                          manufacturingDate = pickedDate;
                        });
                      },
                      label: Text(date == null
                        ? 'Pick a date'
                        : DateFormat('yyyy-MM-dd').format(date),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: betweenText,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if(_createProductForm.currentState!.validate() && manufacturingDate != null) {
                            setState(() {
                              bannerMessage = createProduct(productName, productManufacturer, manufacturingDate!, warranty);
                            });
                            Navigator.pop(context, bannerMessage);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade800,
                        ),
                        child: Text('Create', style: createButtonStyle),
                      ),
                    ),
                  ],
                ),
              ],
            ), 
          ),
        ),
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