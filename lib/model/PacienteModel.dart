import 'package:fichas_med_app/model/PersonaModel.dart';

class PacienteModel {
  int? id;
  String? nroSeguro;
  PersonaModel? persona;

  PacienteModel({this.id, this.nroSeguro, this.persona});

  PacienteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nroSeguro = json['nroSeguro'];
    persona =
        json['persona'] != null ? PersonaModel.fromJson(json['persona']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nroSeguro'] = nroSeguro;
    if (persona != null) {
      data['persona'] = persona!.toJson();
    }
    return data;
  }
}
