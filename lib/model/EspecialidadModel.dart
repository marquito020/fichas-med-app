class EspecialidadModel {
  int? id;
  String? nombre;
  String? descripcion;
  bool? activo;

  EspecialidadModel({this.id, this.nombre, this.descripcion, this.activo});

  EspecialidadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    activo = json['activo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['descripcion'] = descripcion;
    data['activo'] = activo;
    return data;
  }

  @override
  String toString() {
    return 'Especialidadmodel{id: $id, nombre: $nombre, descripcion: $descripcion, activo: $activo}';
  }
}
