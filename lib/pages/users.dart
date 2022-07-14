import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminUsers extends StatefulWidget {
  AdminUsers({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminUsers();
  }
}

class _AdminUsers extends State<AdminUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Gestione condominiale',
                style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
            Text('Gestisci utenti',
                style: TextStyle(fontSize: 15, color: Colors.green)),
          ],
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: Center(child: Text('Users')),
    );
  }
}

