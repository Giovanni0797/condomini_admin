part 'Riparto.g.dart';

class Riparto {
  int? id;
  String? sigla;
  String? voce_contabile;
  String? raggruppamento;
  double? importo;

  Riparto({this.id, this.sigla, this.voce_contabile, this.raggruppamento, this.importo});

  factory Riparto.fromJson(Map<String, dynamic> json) => _$RipartoFromJson(json);

  Map<String, dynamic> toJson() => _$RipartoToJson(this);
}
