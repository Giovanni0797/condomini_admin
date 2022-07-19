part 'Spesa.g.dart';

class Spesa {
  int? id;
  int? id_riparti;
  String? voce_contabile;
  double? importo;
  double? parti_uguali;
  double? spese_personali;

  Spesa({this.id, this.id_riparti, this.voce_contabile, this.importo, this.parti_uguali, this.spese_personali});

  factory Spesa.fromJson(Map<String, dynamic> json) => _$SpesaFromJson(json);

  Map<String, dynamic> toJson() => _$SpesaToJson(this);
}
