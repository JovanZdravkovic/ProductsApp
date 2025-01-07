import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:products_app/services/products_service.dart';
import 'package:products_app/utils/constants.dart';
import 'package:products_app/utils/response.dart';

class CreateProductPage extends StatefulWidget {

  const CreateProductPage({ super.key, required this.productsService });

  final ProductsService productsService;

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
    var date = manufacturingDate;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create product', style: Theme.of(context).textTheme.headlineMedium!),
      ),
      body: Center(
        child: Form(
          key: _createProductForm,
          child: Padding(
            padding: STANDARD_PADDING,
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
                SPACING_BOX,
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
                SPACING_BOX,
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
                SPACING_BOX,
                Row(
                  children: [
                    Text('Manufacturing date:', style: formTextStyle),
                    SPACING_BOX,
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
                        : DateFormat(DATE_FORMAT).format(date),
                      ),
                    ),
                  ],
                ),
                SPACING_BOX,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if(_createProductForm.currentState!.validate() && manufacturingDate != null) {
                            setState(() {
                              bannerMessage = widget.productsService.createProduct(productName, productManufacturer, manufacturingDate!, warranty);
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