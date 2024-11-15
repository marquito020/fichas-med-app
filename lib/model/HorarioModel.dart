import 'package:fichas_med_app/model/DoctorModel.dart';

class HorarioModel {
  int? id;
  String? fecha;
  String? dia;
  bool? activo;
  String? horaInicio; // Campo adicional
  String? horaFin; // Campo adicional
  DoctorModel? doctor;

  HorarioModel({
    this.id,
    this.fecha,
    this.dia,
    this.activo,
    this.horaInicio,
    this.horaFin,
    this.doctor,
  });

  HorarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fecha = json['fecha'];
    dia = json['dia'];
    activo = json['activo'];
    horaInicio = json['horaInicio']; // Nuevo campo
    horaFin = json['horaFin']; // Nuevo campo
    doctor =
        json['doctor'] != null ? DoctorModel.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fecha'] = fecha;
    data['dia'] = dia;
    data['activo'] = activo;
    data['horaInicio'] = horaInicio; // Nuevo campo
    data['horaFin'] = horaFin; // Nuevo campo
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    return data;
  }
}
