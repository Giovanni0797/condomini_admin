import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminHome();
  }
}

class _AdminHome extends State<AdminHome> {
  double tot_tab_a = 1521.0;
  double tot_tab_b = 1521.0;
  double tot_tab_c = 1521.0;
  double tot_tab_d = 1521.0;
  double tot_tab_e = 1521.0;
  double tot_tab_f = 1521.0;
  double tot_tab_h = 1521.0;
  double spese_condivise = 1151.0;
  double spese_personali = 1475.0;

  @override
  initState() {
    super.initState();
    double tot_spese;
  }
  //setState(() {
  //double tot_spese = tot_tab_a + tot_tab_b + tot_tab_c + tot_tab_d +
  //tot_tab_e + tot_tab_f + tot_tab_h + spese_condivise + spese_personali;
  //});

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
                    Icon(Icons.monetization_on_outlined, color: Colors.green,
                        size: 35),
                    Text(' Spese attuali', style: TextStyle(fontSize: 30,
                        color: Colors.green,
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
                    Text('• Spese condivise = ', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('$spese_condivise€', style: TextStyle(fontSize: 20)),
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
                        color: Colors.green)),
                    Text('tot_spese€', style: TextStyle(
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