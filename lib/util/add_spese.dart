import 'dart:core';
import 'dart:ffi';
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

class AddSpesa extends StatefulWidget {
  final int id_utente;
  final String nome_utente;
  List<Utente> utenti;
  AddSpesa({Key? key, required this.id_utente, required this.nome_utente, required this.utenti}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddSpesa();
  }
}

class _AddSpesa extends State<AddSpesa> {
  List<Utente> utenti = [];
  List<Riparto> riparti = [];
  //List<Spesa> spese = [];
  List<String> voce_contabile = [];
  List<String> importo = [];
  List<String> dropdown = [];

  int id_riparto = 0;
  String dropdownvalue = '';
  String dropdownvalue2 = 'A';
  double parti_uguali = 0.0;
  double spese_personali = 0.0;
  bool tappedYes = false;
  bool loading = false;

  TextEditingController parti_uguali_controller = TextEditingController();
  TextEditingController spese_personali_controller = TextEditingController();

  @override
  initState() {
    super.initState();

    recRiparto(link_admin + 'riparti_read_all.php?id_utente=' + widget.id_utente.toString())
        .then((value) => {
      riparti = value,
      for (int i = 0; i < riparti.length; i++){
        voce_contabile.add(riparti[i].voce_contabile!),
        //print(voce_contabile),
      },

      for (int i = 0; i < riparti.length; i++){
        importo.add(riparti[i].importo.toString()),
        //print(importo),
      },

      for (int i = 0; i < riparti.length; i++){
        dropdown.add(voce_contabile[i] + ' - €' + importo[i].toString()),
        //print(dropdown),
      },

    setState(() {
      dropdownvalue = dropdown[0];
      loading = true;
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
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.white)),
            Text('Aggiungi spesa',
                style: TextStyle(fontSize: 15, color: verde)),
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
                    Text('Utente selezionato: ',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    Text(widget.nome_utente,
                        style: TextStyle(fontSize: 18)
                    ),
                  ],
                )
              ],
            ),
          ),

          //SELEZIONA RIPARTO
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Seleziona riparto: ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          //RIPARTO DROPDOWN
          loading ? Center(
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
                    int j = dropdown.indexOf(dropdownvalue);
                    id_riparto = riparti[j].id!;
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return dropdown.map<Widget>((String item) {
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
                items: dropdown.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Color(0xFFd2d3d3))),
                  );
                }).toList(),
              ),
            ),
          ) : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: def2,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Nessun riparto trovato', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          //INSERISCI PARTI UGUALI
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Inserisci parti uguali: ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),

          //PARTI UGUALI
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 5.0, right: 16.0),
              child: Expanded(
                child: TextField(
                  controller: parti_uguali_controller,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: bianco),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: def2,
                    hintText: 'Inserisci',
                    hintStyle: TextStyle(color: bianco),
                    labelText: 'Parti uguali',
                    labelStyle: TextStyle(color: bianco),
                    suffixIcon: parti_uguali_controller.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => parti_uguali_controller.clear()
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
          ),


          SizedBox(height: 10),
          //SPESE PERSONALI
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Inserisci spese personali: ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          //SPESE PERSONALI
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 5.0, right: 16.0),
              child: Expanded(
                child: TextField(
                  controller: spese_personali_controller,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: bianco),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: def2,
                    hintText: 'Inserisci',
                    hintStyle: TextStyle(color: bianco),
                    labelText: 'Spese personali',
                    labelStyle: TextStyle(color: bianco),
                    suffixIcon: spese_personali_controller.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => spese_personali_controller.clear()
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
          ),

          //INSERISCI RIPARTO
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () async {
                  final action = await AlertDialogs.yesCancelDialog(context, 'Aggiungere spesa', 'Sei sicuro?');
                  if(action == DialogsAction.yes) {
                    setState(() {
                      tappedYes = true;
                      InsSpesa(link_admin + 'spese_insert.php?id_riparti='+id_riparto.toString()+'&parti_uguali='+parti_uguali_controller.text.toString()+'&spese_personali='+spese_personali_controller.text.toString(), context);

                      setState(() {
                        dropdownvalue = dropdown[0];
                        parti_uguali_controller.text = '';
                        spese_personali_controller.text = '';
                      });
                    });
                  } else {
                    setState(() => tappedYes = false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: verde,
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                child: Text(
                  'Aggiungi spesa'.toUpperCase(),
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

Future<void> InsSpesa(String link, BuildContext context) async {
  final response = await http.get(Uri.parse(link));
  if (response.statusCode == 200) {
    print('Ins spesa OK');
  } else {
    throw Exception('Failed to load data');
  }
}

  Future<List<Riparto>> recRiparto(String link) async {
    final response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      //print(response.body);
      if (response.body != '0') {
        var Lista_RipartiJson = jsonDecode(response.body)["riparti"] as List;
        List<Riparto> Lista_Riparti =
        Lista_RipartiJson.map((tagJson) => Riparto.fromJson(tagJson)).toList();
        //print(Lista_RipartiJson);
        return Lista_Riparti;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
