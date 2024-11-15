import 'package:fichas_med_app/model/PacienteModel.dart';
import 'package:fichas_med_app/model/ReservaModel.dart';
import 'package:fichas_med_app/model/TratamientoModel.dart';

class HistorialClinicoModel {
  int? id;
  String? fechaCreacion;
  String? titulo;
  String? descripcion;
  String? tipoHistoria;
  bool? activo;
  PacienteModel? paciente;
  List<TratamientoModel>? tratamientos;

  HistorialClinicoModel({
    this.id,
    this.fechaCreacion,
    this.titulo,
    this.descripcion,
    this.tipoHistoria,
    this.activo,
    this.paciente,
    this.tratamientos,
  });

  HistorialClinicoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fechaCreacion = json['fechaCreacion'];
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    tipoHistoria = json['tipoHistoria'];
    activo = json['activo'];
    paciente =
        json['paciente'] != null ? PacienteModel.fromJson(json['paciente']) : null;
    if (json['tratamientos'] != null) {
      tratamientos = (json['tratamientos'] as List)
          .map((t) => TratamientoModel.fromJson(t))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['fechaCreacion'] = fechaCreacion;
    data['titulo'] = titulo;
    data['descripcion'] = descripcion;
    data['tipoHistoria'] = tipoHistoria;
    data['activo'] = activo;
    if (paciente != null) {
      data['paciente'] = paciente!.toJson();
    }
    if (tratamientos != null) {
      data['tratamientos'] = tratamientos!.map((t) => t.toJson()).toList();
    }
    return data;
  }
}
