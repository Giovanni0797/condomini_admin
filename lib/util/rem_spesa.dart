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
  List<int> id_spesa = [];
  List<int> id_riparto = [];
  List<String> dropdown = [];
  bool loading = false;
  bool tappedYes = false;
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
        id_spesa.add(spese[i].id!),
        //print(id_spesa),
      },

      for (int i = 0; i < spese.length; i++){
        id_riparto.add(spese[i].id_riparti!),
        print(id_riparto),
      },

      for (int i = 0; i < spese.length; i++){
        dropdown.add(voce_contabile[i] + ' - €' + importo[i] + ' - €' + parti_uguali[i] + ' - €' + spese_personali[i]),
        //print(dropdown),
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

          loading ? Container(
            height: MediaQuery.of(context).size.height*0.78,
            width: MediaQuery.of(context).size.width*0.98,
            //decoration: BoxDecoration(
            //    color: def2,
            //    borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 600,
                      childAspectRatio: 4 / 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: dropdown.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: def2,
                          borderRadius: BorderRadius.circular(15)),
                      child:
                       Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete_forever),
                                color: Colors.red[300],
                                iconSize: 40,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed: () async {
                                  final action = await AlertDialogs.yesCancelDialog(context, 'Rimuovere spesa ' + ((index)+1).toString(), 'Sei sicuro?');
                                  if(action == DialogsAction.yes) {
                                    setState(() {
                                      tappedYes = true;
                                      delSpesa(link_admin + 'spese_delete.php?id='+id_spesa[index].toString(), context, index);
                                      delRiparto(link_admin + 'riparti_delete.php?id='+id_riparto[index].toString(), context);
                                    });
                                  } else {
                                    setState(() => tappedYes = false);
                                  }
                                },
                              ),
                            ],
                          ),
                          title: Text((index+1).toString() + ') ' + voce_contabile[index], style: TextStyle(color: bianco, fontWeight: FontWeight.bold, fontSize: 16)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Importo: ' + importo[index],
                                  style: TextStyle(color: bianco, fontSize: 14.5)
                              ),
                              Text(
                                  'Parti uguali: ' + parti_uguali[index],
                                  style: TextStyle(color: bianco, fontSize: 14.5)
                              ),
                              Text(
                                  'Spese personali: ' + spese_personali[index],
                                  style: TextStyle(color: bianco, fontSize: 14.5)
                              ),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      ),
                    );
                  }),
            ),
          ) : Column(
            children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.98,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: def2,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Nessuna spesa trovata', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }


Future<void> delSpesa(String link, BuildContext context, int index) async {
  final response = await http.get(Uri.parse(link));
  if (response.statusCode == 200) {
    print('Rem spesa OK');
    setState(() {
      dropdown.removeAt(index);
      id_spesa.removeAt(index);
      voce_contabile.removeAt(index);
      importo.removeAt(index);
      parti_uguali.removeAt(index);
      spese_personali.removeAt(index);
    });
  } else {
    throw Exception('Failed to load data');
  }
}

  Future<void> delRiparto(String link, BuildContext context) async {
    final response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      print('Rem riparto OK');
    } else {
      throw Exception('Failed to load data');
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

}