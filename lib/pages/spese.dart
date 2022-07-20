import 'package:condomini_admin/data_layer/Riparto.dart';
import 'package:condomini_admin/data_layer/Spesa.dart';
import 'package:condomini_admin/util/add_riparto.dart';
import 'package:condomini_admin/util/add_spese.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:condomini_admin/data_layer/Utente.dart';
import 'package:condomini_admin/globals.dart';

import '../util/rem_spesa.dart';

class AdminSpese extends StatefulWidget {
  AdminSpese({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminSpese();
  }
}

class _AdminSpese extends State<AdminSpese> {
  List<Utente> utenti = [];
  List<String> nomeutente = [];
  List<int> idutente = [];
  String dropdownvalue = '';

  String interno = '';
  String piano = '';
  String scala = '';
  int id_utente = 0;

  @override
  initState() {
    super.initState();
    recUtente('https://www.mavreality.it/condomini/api_amministratore/utenti_read_all.php')
        .then((value) => {
              utenti = value,
              for (int i = 0; i < utenti.length; i++)
                {
                  nomeutente.add(utenti[i].nome_cognome!),
                  //print(nomeutente),
                },
                for (int i = 0; i < utenti.length; i++)
                  {
                    idutente.add(utenti[i].id!),
                    //print(idutente),
                  },

              setState(() {
                id_utente = idutente[0];
                dropdownvalue = nomeutente[0];
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
            Text('Gestione condominiale',
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.white)),
            Text('Gestisci spese',
                style: TextStyle(fontSize: 15, color: verde)),
          ],
        ),
        backgroundColor: bar,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          //SELEZIONA UTENTE
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: def2,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: DropdownButton<String>(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.keyboard_arrow_down, color: bianco),
                ),
                dropdownColor: def2,
                //borderRadius: BorderRadius.all(Radius.circular(20)),
                style: TextStyle(fontSize: 16),
                underline: SizedBox(),
                value: dropdownvalue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    int j = nomeutente.indexOf(dropdownvalue);
                    interno = utenti[j].interno!;
                    piano = utenti[j].piano!;
                    scala = utenti[j].scala!;
                    id_utente = utenti[j].id!;
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return nomeutente.map<Widget>((String item) {
                    return Container(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
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
                    child: Text(value, style: TextStyle(color: Color(0xFFd2d3d3))),
                  );
                }).toList(),
              ),
            ),
          ),
          //BOTTONI AZIONI
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 50),
            child: Text('Seleziona un\'azione da eseguire: ',
                style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4, right: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      width: 115,
                      child: OutlinedButton(child: Text('Aggiungi riparto', style: TextStyle(color: verde, fontSize: 12)),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddRiparto(id_utente: id_utente, nome_utente: dropdownvalue, utenti: utenti)));
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: verde,
                            style: BorderStyle.solid,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      width: 115,
                      child: OutlinedButton(child: Text('Aggiungi spesa', style: TextStyle(color: verde, fontSize: 12)),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddSpesa(id_utente: id_utente, nome_utente: dropdownvalue, utenti: utenti)));
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: verde,
                            style: BorderStyle.solid,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      width: 115,
                      child: OutlinedButton(child: Text('Rimuovi spesa', style: TextStyle(color: verde, fontSize: 12)),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RemSpesa(id_utente: id_utente, nome_utente: dropdownvalue, utenti: utenti)));
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: verde,
                            style: BorderStyle.solid,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
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

}