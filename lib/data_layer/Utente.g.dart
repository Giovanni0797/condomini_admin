part of 'Utente.dart';

Utente _$UtenteFromJson(Map<String, dynamic> json) {
  return Utente(
    id: json["id"] as int,
    nome_cognome: json["nome_cognome"] as String,
    tipo_utente: json["tipo_utente"] as String,
    millesimali: double.parse(json["millesimali"].toString()),
    interno: json["interno"] as String,
    piano: json["piano"] as String,
    scala: json["scala"] as String,
  );
}
Map<String, dynamic> _$UtenteToJson(Utente instance) => <String, dynamic>{
  '"id"': '"' + instance.id.toString() + '"',
  '"nome_cognome"': '"' + instance.nome_cognome! + '"',
  '"tipo_utente"': '"' + instance.tipo_utente! + '"',
  '"millesimali"': '"' + instance.millesimali.toString() + '"',
  '"interno"': '"' + instance.interno! + '"',
  '"piano"': '"' + instance.piano! + '"',
  '"scala"': '"' + instance.scala! + '"',
};
