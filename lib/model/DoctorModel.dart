import 'package:fichas_med_app/model/EspecialidadModel.dart';
import 'package:fichas_med_app/model/PersonaModel.dart';

class DoctorModel {
  int? id;
  EspecialidadModel? especialidad;
  PersonaModel? persona;

  DoctorModel({this.id, this.especialidad, this.persona});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    especialidad = json['especialidad'] != null
        ? EspecialidadModel.fromJson(json['especialidad'])
        : null;
    persona = json['persona'] != null ? PersonaModel.fromJson(json['persona']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (especialidad != null) {
      data['especialidad'] = especialidad!.toJson();
    }
    if (persona != null) {
      data['persona'] = persona!.toJson();
    }
    return data;
  }
}
