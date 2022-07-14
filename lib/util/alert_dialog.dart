import 'package:condomini_admin/globals.dart';
import 'package:flutter/material.dart';

enum DialogsAction {yes, cancel}

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
      BuildContext context,
      String title,
      String body,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: def2,
          insetPadding: EdgeInsets.all(1.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(title, style: TextStyle(color: bianco)),
          content: Text(body, style: TextStyle(color: bianco)),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
              child: Text(
                'Conferma',
                style: TextStyle(
                    color: Color(0xFFa3ffc3), fontWeight: FontWeight.w700),
              ),
            ),
            FlatButton(
              onPressed: () =>
                  Navigator.of(context).pop(DialogsAction.cancel),
              child: Text(
                'Annulla',
                style: TextStyle(
                    color: bianco, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }
}