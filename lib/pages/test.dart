import 'package:condomini_admin/util/alert_dialog.dart';
import 'package:condomini_admin/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:condomini_admin/data_layer/Utente.dart';
import 'package:flutter/services.dart';
import 'package:condomini_admin/globals.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Utente> utenti = [];
  List<int> idutente = [];
  List<String> nomeutente = [];
  String dropdownvalue = '';

  String nome = 'Seleziona utente';
  String interno = 'Seleziona utente';
  String piano = 'Seleziona utente';
  String scala = 'Seleziona utente';
  double millesimali = 0.0;
  int id = 0;
  int j = 0;

  TextEditingController controller = TextEditingController()..text='';

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
      resizeToAvoidBottomInset: false,
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
      backgroundColor: def2,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                GestureDetector(
                  onLongPress: () async {
                    final action = await AlertDialogs.yesCancelDialog(context, 'Eliminare utente "' + dropdownvalue + '"', 'Sei sicuro?');
                    if(action == DialogsAction.yes) {
                      setState(() {
                        tappedYes = true;
                        cancUtente(link + 'utenti_delete.php?id='+id.toString(), context);
                        dropdownvalue = nomeutente[0];
                      });
                    } else {
                      setState(() => tappedYes = false);
                    }
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(child: Text('${nome[0]}', style: TextStyle(color: def, fontSize: 60, fontWeight: FontWeight.bold))),
                  ),
                ),
                Text(
                  "Tieni premuto per eliminare",
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: bianco,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 24,
                  right: 24,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "PROFILO",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: DropdownButton<String>(
                          icon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                          ),
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          underline: SizedBox(),
                          value: dropdownvalue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              j = nomeutente.indexOf(dropdownvalue);
                              nome = utenti[j].nome_cognome!;
                              interno = utenti[j].interno!;
                              piano = utenti[j].piano!;
                              scala = utenti[j].scala!;
                              millesimali = utenti[j].millesimali!;
                              id = utenti[j].id!;
                              controller.text=millesimali.toString();
                            });
                          },
                          selectedItemBuilder: (BuildContext context) {
                            return nomeutente.map<Widget>((String item) {
                              return Container(
                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  width: 300,
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
                                          Text(item, style: TextStyle(color: Colors.black)),
                                        ],
                                      ),
                                    ],
                                  ));
                            }).toList();
                          },
                          items: nomeutente.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0, bottom: 10),
                                    child: Text(value, style: TextStyle(color: def2)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(width: 1.0, color: def2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    listProfile(Icons.person, Colors.black,  "Nome e cognome", "$nome"),
                    listProfile(Icons.apartment, Colors.black, "Interno", "$interno"),
                    listProfile(Icons.menu, Colors.black, "Piano", "$piano"),
                    listProfile(Icons.stairs, Colors.black, "Scala", "$scala"),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(Icons.app_registration_rounded, color: Colors.green[600], size: 28),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                if (controller.text.isNotEmpty){
                                  millesimali = double.parse(controller.text);
                                  print(millesimali);
                                  upMillesimali(link + 'utenti_update.php?id='+id.toString()+'&millesimali='+millesimali.toString(), context);
                                  setState(() {
                                    utenti[j].millesimali = double.parse(controller.text);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text("Millesimali aggiornati", style: TextStyle(fontSize: 16)),
                                      backgroundColor: verde,
                                    ));
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      content: Text("Millesimali vuoti", style: TextStyle(fontSize: 16)),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                          ),
                          const SizedBox(width: 28),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Millesimali',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "Montserrat",
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 290,
                                  child: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: "Montserrat", fontSize: 16),
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: def),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: def),
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(top: 4),
                                      hintText: "Inserisci",
                                      hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: "Montserrat", fontSize: 16),
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listProfile(IconData icon, Color color, String text1, String text2) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(width: 24,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: "Montserrat",
                  fontSize: 14,
                ),
              ),
              Text(
                text2,
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
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
      print('Utente eliminato OK');
    } else {
      throw Exception('Failed to load data');
    }
  }
  
}