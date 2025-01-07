import 'package:flutter/material.dart';
import 'package:products_app/models/product.dart';
import 'package:products_app/utils/constants.dart';


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
        padding: STANDARD_PADDING,
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