import 'package:condomini_admin/util/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:condomini_admin/data_layer/Utente.dart';
import 'package:flutter/services.dart';
import 'package:condomini_admin/globals.dart';

class AdminUsers extends StatefulWidget {
  AdminUsers({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminUsers();
  }
}

class _AdminUsers extends State<AdminUsers> {

  List<Utente> utenti = [];
  List<int> idutente = [];
  List<String> nomeutente = [];
  String dropdownvalue = '';

  String interno = 'Seleziona utente';
  String piano = 'Seleziona utente';
  String scala = 'Seleziona utente';
  double millesimali = 0.0;
  int id = 0;


  TextEditingController controller = TextEditingController();

  bool tappedYes = false;

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
                style: TextStyle(fontWeight: FontWeight.w700, color: bianco)),
            Text('Gestisci utenti',
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
                borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    millesimali = utenti[j].millesimali!;
                    id = utenti[j].id!;
                    controller = TextEditingController()..text=millesimali.toString();
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 50.0),
            child: Column(
              children: [
                //NOME E COGNOME
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Nome e cognome: ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(dropdownvalue,
                        style: TextStyle(fontSize: 16, color: Color(0xFFd2d3d3))),
                  ],
                ),
                SizedBox(height: 10),
                //INTERNO
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Interno: ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(interno,
                        style: TextStyle(fontSize: 16, color: Color(0xFFd2d3d3))),
                  ],
                ),
                SizedBox(height: 10),
                //PIANO
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Piano: ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(piano,
                        style: TextStyle(fontSize: 16, color: Color(0xFFd2d3d3))),
                  ],
                ),
                SizedBox(height: 10),
                //SCALA
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Scala: ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(scala,
                        style: TextStyle(fontSize: 16, color: Color(0xFFd2d3d3))),
                  ],
                ),
                //MILLESIMALI
                Row(
                  children: [
                    Text('Millesimali: ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 16, color: Color(0xFFd2d3d3)),
                        decoration: InputDecoration.collapsed(
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          hintText: "Inserisci",
                          hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextButton(child: Text('Modifica', style: TextStyle(color: verde)),
                        onPressed: () {
                          if (controller.text.isNotEmpty){
                            millesimali = double.parse(controller.text);
                            upMillesimali(link_admin + 'utenti_update.php?id='+id.toString()+'&millesimali='+millesimali.toString(), context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                content: Text("Millesimali vuoti", style: TextStyle(fontSize: 18),)
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //CANCELLA UTENTE
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () async {
                  final action = await AlertDialogs.yesCancelDialog(context, 'Eliminare utente "' + dropdownvalue + '"', 'Sei sicuro?');
                  if(action == DialogsAction.yes) {
                    setState(() {
                      tappedYes = true;
                      //cancUtente(link_admin + 'utenti_delete.php?id='+id.toString(), context);
                    });
                  } else {
                    setState(() => tappedYes = false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: def2,
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                child: Text(
                  'Elimina utente'.toUpperCase(),
                  style: TextStyle(color: bianco, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
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

Future<void> upMillesimali(String link, BuildContext context) async {
  final response = await http.get(Uri.parse(link));
  if (response.statusCode == 200) {
    print('Update millesimali OK');
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> cancUtente(String link, BuildContext context) async {
  final response = await http.get(Uri.parse(link));
  if (response.statusCode == 200) {
    print('Update millesimali OK');
  } else {
    throw Exception('Failed to load data');
  }
}
