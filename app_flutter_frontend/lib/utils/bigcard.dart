import 'package:flutter/material.dart';
import 'package:products_app/models/product.dart';
import 'package:products_app/utils/constants.dart';
import 'package:products_app/utils/theme.dart';


class BigCard extends StatelessWidget {

  const BigCard({super.key, required this.p});

  final Product p;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: STANDARD_PADDING,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${p.productName}', style: cardTextTheme.bodyLarge),
            Text('Manufacturer: ${p.productManufacturer}', style: cardTextTheme.bodyLarge),
            Text('Warranty: ${p.warranty}', style: cardTextTheme.bodyLarge),
            Text('Manufactured date: ${p.productManufacturingDate}', style: cardTextTheme.bodyLarge),
          ],
        ) ,
      ), 
    );
  }
}