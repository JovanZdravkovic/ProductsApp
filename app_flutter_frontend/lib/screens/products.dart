import 'package:flutter/material.dart';
import 'package:products_app/screens/create_product.dart';
import 'package:products_app/services/base_service.dart';
import 'package:products_app/services/products_service.dart';
import 'package:products_app/utils/alertbanner.dart';
import 'package:products_app/utils/bigcard.dart';
import 'package:products_app/utils/constants.dart';
import 'package:products_app/models/product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({
    super.key,
    required this.baseService,
    required this.productsService
  });

  final BaseService baseService;
  final ProductsService productsService;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  late Future<List<Product>> futureProductsList;

  @override
  void initState() {
    super.initState();
    futureProductsList = widget.productsService.fetchProducts();
  }

  Future<void> navigateCreateProduct(BuildContext context) async {
    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
    final bannerMessage = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => CreateProductPage(productsService: widget.productsService,)),
    );

    if (!context.mounted || bannerMessage == null) {
      return;
    }

    ScaffoldMessenger.of(context).showMaterialBanner(alertBanner(context, bannerMessage.responseMessage, bannerMessage.statusCode));
    setState(() {
      futureProductsList = widget.productsService.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Products', style: Theme.of(context).textTheme.headlineMedium!),
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
              return const Text('Failed to load products');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: SizedBox(
        height: FLOATING_BUTTON_HEIGHT,
        width: FLOATING_BUTTON_WIDTH,
        child: FittedBox(
          child: FloatingActionButton.large(
            onPressed: () => {
              navigateCreateProduct(context)
            },
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange.shade800,
            shape: const CircleBorder(),
            child: FLOATING_BUTTON_ICON,
          ),
        ),
      ),
    );
  }
}