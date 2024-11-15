import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:fichas_med_app/model/DocumentoModel.dart';
import 'package:fichas_med_app/model/TratamientoModel.dart';
import 'package:nb_utils/nb_utils.dart';

class TratamientoDetallePacienteScreen extends StatefulWidget {
  final TratamientoModel tratamiento;

  const TratamientoDetallePacienteScreen({Key? key, required this.tratamiento})
      : super(key: key);

  @override
  _TratamientoDetallePacienteScreenState createState() =>
      _TratamientoDetallePacienteScreenState();
}

class _TratamientoDetallePacienteScreenState
    extends State<TratamientoDetallePacienteScreen> {
  List<DocumentoModel> _documentos = [];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _loadDocumentos();
  }

  /// Carga la lista de documentos del tratamiento
  void _loadDocumentos() {
    setState(() {
      _documentos = widget.tratamiento.documentos ?? [];
    });
  }

  /// Descarga una imagen desde su URL y permite guardarla localmente
  Future<void> _downloadImage(String url) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String message;

    try {
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      final dir = await getTemporaryDirectory();
      final fileName = '${dir.path}/tratamiento_${_random.nextInt(100)}.png';
      final file = File(fileName);
      await file.writeAsBytes(response.data);

      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final savedPath = await FlutterFileDialog.saveFile(params: params);

      message = savedPath != null
          ? 'Imagen guardada en: $savedPath'
          : 'El usuario canceló la descarga.';
    } catch (e) {
      message = 'Error al guardar la imagen: $e';
    }

    scaffoldMessenger.showSnackBar(SnackBar(
      content:
          Text(message, style: boldTextStyle(size: 14, color: Colors.white)),
      backgroundColor: Colors.blueAccent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final tratamiento = widget.tratamiento;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Tratamiento'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información del tratamiento
            Text(tratamiento.titulo ?? 'Sin título',
                style: boldTextStyle(size: 18, color: Colors.blueAccent)),
            const SizedBox(height: 8),
            Text('Detalle: ${tratamiento.detalle ?? 'Sin detalle'}',
                style: secondaryTextStyle(size: 14)),
            const SizedBox(height: 8),
            Text('Receta: ${tratamiento.receta ?? 'Sin receta'}',
                style: secondaryTextStyle(size: 14)),
            const Divider(height: 24, thickness: 1),

            // Lista de documentos
            Text('Documentos:', style: boldTextStyle(size: 16)),
            const SizedBox(height: 8),
            _documentos.isNotEmpty
                ? ListView.builder(
                    itemCount: _documentos.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final documento = _documentos[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: documento.url != null
                              ? Image.network(
                                  documento.url!,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image_not_supported),
                          title: Text(documento.nota ?? 'Sin nota'),
                          subtitle: Text(
                            'Fecha: ${documento.fecha ?? 'Sin fecha'}',
                            style: secondaryTextStyle(size: 12),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.download),
                            onPressed: () {
                              if (documento.url != null) {
                                _downloadImage(documento.url!);
                              } else {
                                toast('No se puede descargar esta imagen');
                              }
                            },
                          ),
                        ),
                      );
                    },
                  )
                : const Text('No hay documentos asociados.'),
          ],
        ),
      ),
    );
  }
}
