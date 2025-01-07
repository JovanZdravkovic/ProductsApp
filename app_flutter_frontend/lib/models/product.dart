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