library alertbanner;

import 'package:flutter/material.dart';

export 'alertbanner.dart';

class AlertBanner {
  static MaterialBanner alertBanner(BuildContext context, String bannerMessage, int statusCode) {
    dynamic typeColor;
    // statusCode == 0 ==> Success banner (green)
    // statusCode == 1 ==> Error banner (red)
    // statusCode != 0,1 ==> Info banner (blue)
    switch (statusCode) {
      case 0:
        typeColor = Colors.green.shade300;
        break; 
      case 1: 
        typeColor = Colors.red.shade600;
        break; 
      default:
        typeColor = Colors.blue;
    }
    return MaterialBanner(
      content: Text(bannerMessage, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
      backgroundColor: typeColor,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }, 
          child: Icon(Icons.close, color: Theme.of(context).colorScheme.onPrimary),
        ),
      ],
    );
  }
}