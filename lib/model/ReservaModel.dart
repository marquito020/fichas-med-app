import 'package:fichas_med_app/model/HorarioModel.dart';

class ReservaModel {
  int? id;
  String? estado;
  String? fechaRegistroReserva;
  String? horarioInicioAtencion;
  String? horarioFinAtencion;
  HorarioModel? horario;
  int? nroFicha;

  ReservaModel({
    this.id,
    this.estado,
    this.fechaRegistroReserva,
    this.horarioInicioAtencion,
    this.horarioFinAtencion,
    this.horario,
    this.nroFicha,
  });

  ReservaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estado = json['estado'];
    fechaRegistroReserva = json['fechaRegistroReserva'];
    horarioInicioAtencion = json['horarioInicioAtencion'];
    horarioFinAtencion = json['horarioFinAtencion'];
    horario =
        json['horario'] != null ? HorarioModel.fromJson(json['horario']) : null;
    nroFicha = json['nroFicha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['estado'] = estado;
    data['fechaRegistroReserva'] = fechaRegistroReserva;
    data['horarioInicioAtencion'] = horarioInicioAtencion;
    data['horarioFinAtencion'] = horarioFinAtencion;
    if (horario != null) {
      data['horario'] = horario!.toJson();
    }
    data['nroFicha'] = nroFicha;
    return data;
  }
}
