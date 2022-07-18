part of 'Riparto.dart';

Riparto _$RipartoFromJson(Map<String, dynamic> json) {
  return Riparto(
    id: json["id"] as int,
    sigla: json["sigla"] as String,
    voce_contabile: json["voce_contabile"] as String,
    raggruppamento: json["raggruppamento"] as String,
    importo: double.parse(json["importo"].toString()),
  );
}
Map<String, dynamic> _$RipartoToJson(Riparto instance) => <String, dynamic>{
  '"id"': '"' + instance.id.toString() + '"',
  '"sigla"': '"' + instance.sigla! + '"',
  '"voce_contabile"': '"' + instance.voce_contabile! + '"',
  '"raggruppamento"': '"' + instance.raggruppamento! + '"',
  '"importo"': '"' + instance.importo.toString() + '"',
};
