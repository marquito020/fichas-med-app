import 'package:fichas_med_app/model/UsuarioModel.dart';

class PersonaModel {
  String? ci;
  String? nombre;
  String? apellido;
  String? telefono;
  String? fechaNacimiento;
  String? sexo;
  UsuarioModel? usuario;

  PersonaModel(
      {this.ci, this.nombre, this.apellido, this.telefono, this.fechaNacimiento, this.sexo, this.usuario});

  PersonaModel.fromJson(Map<String, dynamic> json) {
    ci = json['ci'];
    nombre = json['nombre'];
    apellido = json['apellido'];
    telefono = json['telefono'];
    fechaNacimiento = json['fechaNacimiento'];
    sexo = json['sexo'];
    usuario = json['usuario'] != null ? UsuarioModel.fromJson(json['usuario']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ci'] = ci;
    data['nombre'] = nombre;
    data['apellido'] = apellido;
    data['telefono'] = telefono;
    data['fechaNacimiento'] = fechaNacimiento;
    data['sexo'] = sexo;
    if (usuario != null) {
      data['usuario'] = usuario!.toJson();
    }
    return data;
  }
}
