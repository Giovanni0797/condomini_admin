import 'package:condomini_admin/globals.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:condomini_admin/util/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:condomini_admin/data_layer/Utente.dart';
import 'package:flutter/services.dart';
import 'package:condomini_admin/globals.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminHome();
  }
}

class _AdminHome extends State<AdminHome> {
  List<double> somma = [];
  double tot_tab_a = 0.0;
  double tot_tab_b = 0.0;
  double tot_tab_c = 0.0;
  double tot_tab_d = 0.0;
  double tot_tab_e = 0.0;
  double tot_tab_f = 0.0;
  double tot_tab_g = 0.0;
  double tot_tab_h = 0.0;
  double parti_uguali = 0.0;
  double spese_personali = 0.0;
  double tot_spese = 0.0;

  @override
  initState() {
    super.initState();

    recSomma(link_admin + "tab_sum.php").then((value) => {
      somma = value.toList(),

      setState(() {
        tot_tab_a = somma[0];
        tot_tab_b = somma[1];
        tot_tab_c = somma[2];
        tot_tab_d = somma[3];
        tot_tab_e = somma[4];
        tot_tab_f = somma[5];
        tot_tab_g = somma[6];
        tot_tab_h = somma[7];
        spese_personali = somma[8];
        parti_uguali = somma[9];

        tot_spese = tot_tab_a + tot_tab_b + tot_tab_c + tot_tab_d + tot_tab_e + tot_tab_f + tot_tab_g + tot_tab_h + spese_personali + parti_uguali;
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
                style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
            Text('Resoconto',
                style: TextStyle(fontSize: 15, color: verde)),
          ],
        ),
        backgroundColor: bar,
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
                Row(
                  children: [
                    Text('Benvenuto amministratore! ', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 28)),
                    Icon(Icons.admin_panel_settings, color: Colors.white,
                        size: 30),
                  ],
                ),
                SizedBox(height: 4),
                Text('Ecco l\'attuale resoconto',
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 30),
            child: Column(
              children: [
                //Resoconto spese
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.monetization_on_outlined, color: verde,
                        size: 35),
                    Text(' Spese attuali', style: TextStyle(fontSize: 30,
                        color: verde,
                        fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8),
                //TOTALE TAB A
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('• TAB "A" = ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('$tot_tab_a€', style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(height: 4),
                //TOTALE TAB B
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('• TAB "B" = ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('$tot_tab_b€', style: TextStyle(fontSize: 20)),
                  ],
                ),
                //TOTALE TAB C
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('• TAB "C" = ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('$tot_tab_c€', style: TextStyle(fontSize: 20)),
                  ],
                ),
                //TOTALE TAB D
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('• TAB "D" = ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('$tot_tab_d€', style: TextStyle(fontSize: 20)),
                  ],
                ),
                //TOTALE TAB E
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('• TAB "E" = ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('$tot_tab_e€', style: TextStyle(fontSize: 20)),
                  ],
                ),
                //TOTALE TAB F
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('• TAB "F" = ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('$tot_tab_f€', style: TextStyle(fontSize: 20)),
                  ],
                ),
                //TOTALE TAB G
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('• TAB "G" = ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('$tot_tab_g€', style: TextStyle(fontSize: 20)),
                  ],
                ),
                //TOTALE TAB D
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('• TAB "H" = ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('$tot_tab_h€', style: TextStyle(fontSize: 20)),
                  ],
                ),
                //TOTALE SPESE CONDIVISE
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('• Parti uguali = ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('$parti_uguali€', style: TextStyle(fontSize: 20)),
                  ],
                ),
                //TOTALE SPESE PERSONALI
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('• Spese personali = ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('$spese_personali€', style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(height: 8),
                //TOTALE SPESE CONSUNTIVO
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('TOTALE SPESE CONSUNTIVO = ', style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: verde)),
                    Text(tot_spese.toStringAsFixed(2) + '€', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                //END
                SizedBox(height: 160),
                Column(
                  children: [
                    Text('Scopri le altre spese nella pagina apposita! ', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 28)),
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

/*Future<List<String>> recRiparto(String link) async {
  final response = await http.get(Uri.parse(link));
  if (response.statusCode == 200) {
    //print(response.body);
    if (response.body != '0') {
      var Somma = jsonDecode(response.body) as List;
      return Somma.toList();
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load data');
  }
}*/

Future<List<double>> recSomma(String link) async {
  final response = await http.get(Uri.parse(link));
  if (response.statusCode == 200) {

    List<dynamic> somma = jsonDecode(response.body).map((e) => double.parse(e.toString())).toList();
    //print(somma);
    List<double> doubleList = somma.map((s) => s as double).toList();
    return doubleList;
  } else {
    throw Exception('Failed to load data');
  }
}
