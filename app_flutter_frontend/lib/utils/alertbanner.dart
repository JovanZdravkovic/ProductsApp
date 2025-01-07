library alertbanner;

import 'package:flutter/material.dart';
import 'package:products_app/utils/constants.dart';

export 'alertbanner.dart';

MaterialBanner alertBanner(BuildContext context, String bannerMessage, int statusCode) {
  var contextPrimaryColor = Theme.of(context).colorScheme.onPrimary;
  dynamic alertColor, iconType;
  // statusCode == 0 ==> Success banner (green)
  // statusCode == 1 ==> Error banner (red)
  // statusCode != 0,1 ==> Info banner (blue)
  switch (statusCode) {
    case 0:
      alertColor = Colors.green.shade300;
      iconType = ALERT_SUCCESS_ICON;
      break; 
    case 1: 
      alertColor = Colors.red.shade600;
      iconType = ALERT_ERROR_ICON;
      break; 
    default:
      alertColor = Colors.blue;
      iconType = ALERT_INFO_ICON;
  }
  return MaterialBanner(
    content: Row(
      children: [
        iconType,
        SPACING_BOX,
        Text(bannerMessage, style: TextStyle(color: contextPrimaryColor),)
      ],
    ),
    backgroundColor: alertColor,
    actions: <Widget>[
      TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        }, 
        child: ALERT_CLOSE_ICON,
      ),
    ],
  );
}