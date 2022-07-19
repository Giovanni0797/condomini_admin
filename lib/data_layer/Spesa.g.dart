part of 'Spesa.dart';

Spesa _$SpesaFromJson(Map<String, dynamic> json) {
  return Spesa(
    id: json["id"] as int,
    id_riparti: json["id_riparti"] as int,
    voce_contabile: json["voce_contabile"] as String,
    importo: double.parse(json["importo"].toString()),
    parti_uguali: double.parse(json["parti_uguali"].toString()),
    spese_personali: double.parse(json["spese_personali"].toString()),
  );
}
Map<String, dynamic> _$SpesaToJson(Spesa instance) => <String, dynamic>{
  '"id"': '"' + instance.id.toString() + '"',
  '"id_riparti"': '"' + instance.id_riparti.toString() + '"',
  '"voce_contabile"': '"' + instance.voce_contabile! + '"',
  '"importo"': '"' + instance.importo.toString() + '"',
  '"parti_uguali"': '"' + instance.parti_uguali.toString() + '"',
  '"spese_personali"': '"' + instance.spese_personali.toString() + '"',
};
