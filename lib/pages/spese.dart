import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:condomini_admin/data_layer/Utente.dart';
import 'package:flutter/services.dart';
import 'package:condomini_admin/globals.dart';

class AdminSpese extends StatefulWidget {
  AdminSpese({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminSpese();
  }
}

class _AdminSpese extends State<AdminSpese> {
  List<Utente> utenti = [];
  List<int> idutente = [];
  List<String> nomeutente = [];
  String dropdownvalue = '';

  @override
  initState() {
    super.initState();
    recUtente('https://www.mavreality.it/condomini/api_amministratore/utenti_read_all.php')
        .then((value) => {
              utenti = value,
              for (int i = 0; i < utenti.length; i++)
                {
                  nomeutente.add(utenti[i].nome_cognome!),
                  print(nomeutente),
                },
              for (int i = 0; i < utenti.length; i++)
                {
                  idutente.add(utenti[i].id!),
                  //print(idutente),
                },

              setState(() {
                dropdownvalue = nomeutente[0];
              })
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
            Text('Gestione condominiale',
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.white)),
            Text('Gestisci spese',
                style: TextStyle(fontSize: 15, color: Colors.green)),
          ],
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Benvenuto
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Seleziona l\'utente da gestire: ',
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(4281282353),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: DropdownButton<String>(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              elevation: 16,
              underline: SizedBox(),
              style: const TextStyle(color: Colors.grey),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
              selectedItemBuilder: (BuildContext context) {
                return nomeutente.map<Widget>((String item) {
                  return Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      width: 350,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(item),
                            ],
                          ),
                        ],
                      ));
                }).toList();
              },
              items: nomeutente.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<Utente>> recUtente(String link) async {
  final response = await http.get(Uri.parse(link));
  if (response.statusCode == 200) {
    //print(response.body);
    if (response.body != '0') {
      var Lista_UtentiJson = jsonDecode(response.body)["utenti"] as List;
      List<Utente> Lista_Utenti =
          Lista_UtentiJson.map((tagJson) => Utente.fromJson(tagJson)).toList();
      //print(Lista_UtentiJson);
      return Lista_Utenti;
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load data');
  }
}