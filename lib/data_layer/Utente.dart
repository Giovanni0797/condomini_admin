part 'Utente.g.dart';

class Utente {
  int? id;
  String? nome_cognome;
  String? tipo_utente;
  double? millesimali;
  String? interno;
  String? piano;
  String? scala;

  Utente({this.id, this.nome_cognome, this.tipo_utente, this.millesimali, this.interno, this.piano, this.scala});

  factory Utente.fromJson(Map<String, dynamic> json) => _$UtenteFromJson(json);

  Map<String, dynamic> toJson() => _$UtenteToJson(this);
}
