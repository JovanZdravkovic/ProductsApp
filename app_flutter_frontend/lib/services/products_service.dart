import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:products_app/services/base_service.dart';
import 'package:products_app/utils/constants.dart';
import 'package:products_app/models/product.dart';
import 'package:products_app/utils/response.dart';

class ProductsService {

  final BaseService baseService;

  const ProductsService({ required this.baseService });

  Future<List<Product>> fetchProducts() async {
    final response = await baseService.get('$URL/products');
    if(response.statusCode / 100 == 2) {
      var productObjJson = jsonDecode(response.body) as List;
      List<Product> productsList = productObjJson.map((productJson) => Product.fromJson(productJson)).toList();
      return productsList;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Response> createProduct(String productName, String productManufacturer, DateTime manufacturingDate, bool warranty) async {
    final response = await baseService.create(
      '$URL/products/create',
      <String, dynamic>{
        'productName': productName,
        'productManufacturer': productManufacturer,
        'warranty': warranty,
        'productManufacturingDate': DateFormat(DATE_FORMAT).format(manufacturingDate),
      }
    );
    if(response.statusCode / 100 == 2) {
      return SUCCESS_RESPONSE_PRODUCT;
    } else {
      return ERROR_RESPONSE_PRODUCT;
    }
  }
}