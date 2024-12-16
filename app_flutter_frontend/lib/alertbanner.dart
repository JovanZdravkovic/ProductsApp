library alertbanner;

import 'package:flutter/material.dart';

export 'alertbanner.dart';

class AlertBanner {
  static MaterialBanner alertBanner(BuildContext context, String bannerMessage, int statusCode) {
    var contextPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    dynamic typeColor, iconType;
    // statusCode == 0 ==> Success banner (green)
    // statusCode == 1 ==> Error banner (red)
    // statusCode != 0,1 ==> Info banner (blue)
    switch (statusCode) {
      case 0:
        typeColor = Colors.green.shade300;
        iconType = Icon(Icons.check_circle_outline, color: contextPrimaryColor);
        break; 
      case 1: 
        typeColor = Colors.red.shade600;
        iconType = Icon(Icons.error_outline, color: contextPrimaryColor);
        break; 
      default:
        typeColor = Colors.blue;
        iconType = Icon(Icons.info_outline, color: contextPrimaryColor);
    }
    return MaterialBanner(
      content: Row(
        children: [
          iconType,
          const SizedBox(
            width: 10.0,
          ),
          Text(bannerMessage, style: TextStyle(color: contextPrimaryColor),)
        ],
      ),
      backgroundColor: typeColor,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }, 
          child: Icon(Icons.close, color: contextPrimaryColor),
        ),
      ],
    );
  }
}