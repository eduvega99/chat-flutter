import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context, String title, String subtitle) {
  if ( Platform.isAndroid ) {
    return _createMaterialDialog(context, title, subtitle);
  }
  return _createCupertinoDialog(context, title, subtitle);
}

  _createCupertinoDialog(BuildContext context, String title, String subtitle) {
    return showCupertinoDialog(
      context: context, 
      builder: ( _ ) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Cerrar'),
              onPressed: () => Navigator.pop(context)
            )
          ],
        );
      }, 
    );
  }

  _createMaterialDialog(BuildContext context, String title, String subtitle) {
    return showDialog(
      context: context, 
      builder: ( _ ) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            MaterialButton(
              child: const Text('Cerrar'),
              textColor: Colors.blue,
              elevation: 5,
              onPressed: () => Navigator.pop(context)
            )
          ]
        );
      }
    );
  }