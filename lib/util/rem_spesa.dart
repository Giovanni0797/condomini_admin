import 'dart:core';
import 'package:condomini_admin/data_layer/Riparto.dart';
import 'package:condomini_admin/data_layer/Spesa.dart';
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
  List<Spesa> spese = [];
  List<String> voce_contabile = [];
  List<String> importo = [];
  List<String> parti_uguali = [];
  List<String> spese_personali = [];
  List<String> dropdown = [];
  String dropdownvalue = '';
  bool loading = false;
  String selected = '';

  @override
  void initState() {
    super.initState();

    recSpesa(link_admin + 'spese_read_all.php?id_utente=' + widget.id_utente.toString())
        .then((value) => {
          spese = value,
      for (int i = 0; i < spese.length; i++){
        voce_contabile.add(spese[i].voce_contabile!),
        //print(voce_contabile),
      },

      for (int i = 0; i < spese.length; i++){
        importo.add(spese[i].importo.toString()),
        //print(importo),
      },

      for (int i = 0; i < spese.length; i++){
        parti_uguali.add(spese[i].parti_uguali.toString()),
        //print(parti_uguali),
      },

      for (int i = 0; i < spese.length; i++){
        spese_personali.add(spese[i].spese_personali.toString()),
        //print(spese_personali),
      },


      for (int i = 0; i < spese.length; i++){
        dropdown.add(voce_contabile[i] + ' - €' + importo[i] + ' - €' + parti_uguali[i] + ' - €' + spese_personali[i]),
        print(dropdown),
      },

      setState((){
        dropdown;
        loading = true;
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Gestione condominiale', style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.white)),
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
                    Text('Utente selezionato: ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(widget.nome_utente, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),

          //SPESA DROPDOWN
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Voce contabile - Importo - Parti uguali - Spese personali', style: TextStyle(color: bianco, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          SizedBox(height:10),
          Container(
            height: MediaQuery.of(context).size.height*0.65,
            width: MediaQuery.of(context).size.width*0.98,
            decoration: BoxDecoration(
                color: def2,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListView.builder(
              //TODO: TIENI PREMUTO PER CANCELLARE
                itemCount: dropdown.length,
                itemBuilder: (context, index){
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GestureDetector(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text((index+1).toString() + ') ' + dropdown[index],
                              style: TextStyle(color: bianco))
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selected = dropdown[index];
                        });
                      },
                    ),
                  );
                },
            ),
          ),
          SizedBox(height:10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(selected, style: TextStyle(color: bianco),),
          ),
        ],
      ),
    );
  }
}


Future<List<Spesa>> recSpesa(String link) async {
  final response = await http.get(Uri.parse(link));
  if (response.statusCode == 200) {
    //(response.body);
    if (response.body != '0') {
      var Lista_SpeseJson = jsonDecode(response.body)["spese"] as List;
      List<Spesa> Lista_Spese =
      Lista_SpeseJson.map((tagJson) => Spesa.fromJson(tagJson)).toList();
      //print(Lista_SpeseJson);
      return Lista_Spese;
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load data');
  }
}
