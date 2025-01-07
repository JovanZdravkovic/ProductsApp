import 'package:flutter/material.dart';
import 'package:products_app/utils/response.dart';

// Strings
const URL = 'http://10.0.2.2:8080';
const DATE_FORMAT = 'yyyy-MM-dd';
const APP_TITLE = 'Products app';

// Styles
const STANDARD_PADDING = EdgeInsets.all(20.0);
const FLOATING_BUTTON_ICON = Icon(Icons.add, size: 50.0);
const FLOATING_BUTTON_HEIGHT = 80.0;
const FLOATING_BUTTON_WIDTH = 80.0;
const SPACING_BOX = SizedBox(
  width: 15.0,
  height: 15.0,
);

// Response
const SUCCESS_RESPONSE_PRODUCT = Response(responseMessage: 'Successfully created product.', statusCode: 0);
const ERROR_RESPONSE_PRODUCT = Response(responseMessage: 'Error occurred while creating product.', statusCode: 1);

// Alert banner
const ALERT_SUCCESS_ICON = Icon(Icons.check_circle_outline, color: Colors.white);
const ALERT_ERROR_ICON = Icon(Icons.error_outline, color: Colors.white);
const ALERT_INFO_ICON = Icon(Icons.info_outline, color: Colors.white);
const ALERT_CLOSE_ICON = Icon(Icons.close, color: Colors.white);
