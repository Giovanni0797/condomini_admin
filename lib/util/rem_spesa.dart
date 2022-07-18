import 'dart:core';
import 'package:condomini_admin/util/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:condomini_admin/data_layer/Utente.dart';
import 'package:flutter/services.dart';
import 'package:condomini_admin/globals.dart';

class RemSpesa extends StatefulWidget {
  final int id_utente;
  final String nome_utente;
  List<Utente> utenti;
  RemSpesa({Key? key, required this.id_utente, required this.nome_utente, required this.utenti}) : super(key: key);

  @override
  State<RemSpesa> createState() => _RemSpesaState();
}

class _RemSpesaState extends State<RemSpesa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Gestione condominiale', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
            Text('Rimuovi spesa', style: TextStyle(fontSize: 15, color: verde)),
          ],
        ),
        backgroundColor: bar,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //UTENTE SELEZIONATO
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Utente selezionato: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(widget.nome_utente, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
