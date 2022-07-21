import 'dart:core';
import 'package:condomini_admin/util/alert_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:condomini_admin/data_layer/Utente.dart';
import 'package:flutter/services.dart';
import 'package:condomini_admin/globals.dart';

class AddRiparto extends StatefulWidget {
  final int id_utente;
  final String nome_utente;
  List<Utente> utenti;
  AddRiparto({Key? key, required this.id_utente, required this.nome_utente, required this.utenti}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddRiparto();
  }
}

class _AddRiparto extends State<AddRiparto> {
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String token = '';

  List<Utente> utente = [];
  List<String> voce_contabile = [
    'Amministrazione condominiale',
    'Assicurazione condominiale',
    'Spese amministrazione condominiale',
    'Tenuta conto corrente Banco Posta',
    'Riparazione e sostituzioni su parti comuni',

    'Pulizie scale',
    'Energia elettrica',
  ];

  List<String> lista_raggruppamento = [
    '1b',
    '1a',
    '1b',
    '1b',
    '1a',

    '1b',
    '1b',
  ];

  List<String> lista_tab = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
  ];

  String dropdownvalue = 'Amministrazione condominiale';
  String dropdownvalue2 = 'A';
  String raggruppamento = '';
  double importo = 0.0;
  bool tappedYes = false;

  TextEditingController controller = TextEditingController();

  @override
  initState() {
    super.initState();

    requestPermission();
    loadFCM();
    listenFCM();
    getToken(link_admin + 'utenti_read_token.php?id=' + widget.id_utente.toString()).then((value) =>
    {
      setState(() {
        token = value;
        print(token);
      }),
    });
  }

  //NOTIFICHE FIREBASE
  void sendPushMessage() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAO1zWfpo:APA91bGJD8zt_OTCKRLTDxXSfDTbP9ACLGXYwG2tqOLK4YOggzN3msNTcG-NlhVzHNwmokOOmYVEf_dxE-GCnE8BTR4-T_LwzF3wcV5k69x9Wds0-0q94XIIQeHT_ONHrvM1mmW9Qg2Z'
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'Nuova spesa',
              'title': 'E\' stata aggiunta una nuova spesa da un amministratore!'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": "$token",
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
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
            Text('Aggiungi riparto',
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    Text(widget.nome_utente,
                        style: TextStyle(fontSize: 18)
                    ),
                  ],
                ),
              ],
            ),
          ),

          //VOCE CONTABILE
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Voce contabile: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),

                  ],
                ),
              ],
            ),
          ),
          //VOCE CONTABILE DROPDOWN
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
                    int j = voce_contabile.indexOf(dropdownvalue);
                    raggruppamento = lista_raggruppamento[j];
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return voce_contabile.map<Widget>((String item) {
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(item),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ));
                  }).toList();
                },
                items: voce_contabile.map<DropdownMenuItem<String>>((
                    String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(value,
                                  style: TextStyle(color: Color(0xFFd2d3d3))),
                              Text(lista_raggruppamento[voce_contabile.indexOf(
                                  value)],
                                  style: TextStyle(color: Color(0xFFd2d3d3))),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: bianco),
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

          SizedBox(height: 10),
          //SELEZIONA TAB
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Seleziona tab: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          //TAB DROPDOWN
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
                value: dropdownvalue2,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue2 = newValue!;
                    //int j = voce_contabile.indexOf(dropdownvalue2);
                    //tab = lista_tab[j];
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return lista_tab.map<Widget>((String item) {
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
                items: lista_tab.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(value,
                                  style: TextStyle(color: Color(0xFFd2d3d3))),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: bianco),
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

          SizedBox(height: 10),
          //INSERISCI IMPORTO
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Inserisci importo: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 5.0, right: 16.0),
              child: Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: bianco),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: def2,
                    hintText: 'Inserisci...',
                    hintStyle: TextStyle(color: bianco),
                    labelText: 'Importo',
                    labelStyle: TextStyle(color: bianco),
                    suffixIcon: controller.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => controller.clear()
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
                  final action = await AlertDialogs.yesCancelDialog(
                      context, 'Aggiungere riparto', 'Sei sicuro?');
                  if (action == DialogsAction.yes) {
                    setState(() {
                      tappedYes = true;
                      InsRiparto(link_admin + 'riparti_insert.php?id_utente=' +
                          widget.id_utente.toString() + '&sigla=' +
                          dropdownvalue2 + '&voce_contabile=' + dropdownvalue +
                          '&raggruppamento=' + raggruppamento + '&importo=' +
                          controller.text.toString(), context);

                      setState(() {
                        dropdownvalue = 'Amministrazione condominiale';
                        dropdownvalue2 = 'A';
                        controller.text = '';
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
                  'Aggiungi riparto'.toUpperCase(),
                  style: TextStyle(
                      color: bianco, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> InsRiparto(String link, BuildContext context) async {
    final response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      print('Ins riparto OK');
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> getToken(String link) async {
    final response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      //print(response.body);
      if (response.body != '') {
        var token = jsonDecode(response.body);
        //print(token);
        return token;
      } else {
        return "";
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}