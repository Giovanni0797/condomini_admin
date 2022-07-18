part of 'Spesa.dart';

Spesa _$SpesaFromJson(Map<String, dynamic> json) {
  return Spesa(
    id: json["id"] as int,
    id_riparti: json["id_riparti"] as int,
    parti_uguali: double.parse(json["parti_uguali"].toString()),
    spese_personali: double.parse(json["spese_personali"].toString()),
  );
}
Map<String, dynamic> _$SpesaToJson(Spesa instance) => <String, dynamic>{
  '"id"': '"' + instance.id.toString() + '"',
  '"id_riparti"': '"' + instance.id_riparti.toString() + '"',
  '"parti_uguali"': '"' + instance.parti_uguali.toString() + '"',
  '"spese_personali"': '"' + instance.spese_personali.toString() + '"',
};
