import 'package:fichas_med_app/model/DocumentoModel.dart';

class TratamientoModel {
  int? id;
  String? titulo;
  String? detalle;
  String? receta;
  bool? activo;
  List<DocumentoModel>? documentos;

  TratamientoModel({
    this.id,
    this.titulo,
    this.detalle,
    this.receta,
    this.activo,
    this.documentos,
  });

  TratamientoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    detalle = json['detalle'];
    receta = json['receta'];
    activo = json['activo'];
    if (json['documentos'] != null) {
      documentos = (json['documentos'] as List)
          .map((d) => DocumentoModel.fromJson(d))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = titulo;
    data['detalle'] = detalle;
    data['receta'] = receta;
    data['activo'] = activo;
    if (documentos != null) {
      data['documentos'] = documentos!.map((d) => d.toJson()).toList();
    }
    return data;
  }
}
