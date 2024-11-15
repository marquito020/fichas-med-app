class DocumentoModel {
  int? id;
  String? url;
  String? nota;
  String? fecha;
  bool? activo;

  DocumentoModel({
    this.id,
    this.url,
    this.nota,
    this.fecha,
    this.activo,
  });

  DocumentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    nota = json['nota'];
    fecha = json['fecha'];
    activo = json['activo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['nota'] = nota;
    data['fecha'] = fecha;
    data['activo'] = activo;
    return data;
  }
}
