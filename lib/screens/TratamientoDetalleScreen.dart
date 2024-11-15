import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:fichas_med_app/model/DocumentoModel.dart';
import 'package:fichas_med_app/model/TratamientoModel.dart';
import 'package:fichas_med_app/services/upload_image_service.dart';
import 'package:fichas_med_app/services/documento_service.dart';
import 'package:nb_utils/nb_utils.dart';

class TratamientoDetalleScreen extends StatefulWidget {
  final TratamientoModel tratamiento;

  const TratamientoDetalleScreen({Key? key, required this.tratamiento})
      : super(key: key);

  @override
  _TratamientoDetalleScreenState createState() =>
      _TratamientoDetalleScreenState();
}

class _TratamientoDetalleScreenState extends State<TratamientoDetalleScreen> {
  final UploadImageService _uploadImageService = UploadImageService();
  final DocumentoService _documentoService = DocumentoService();
  File? _capturedImage;
  String _nota = '';
  bool _isUploading = false;
  List<DocumentoModel> _documentos = [];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _loadDocumentos();
  }

  /// Carga la lista de documentos del tratamiento
  Future<void> _loadDocumentos() async {
    setState(() {
      _documentos = widget.tratamiento.documentos ?? [];
    });
  }

  /// Abre el escáner de documentos
  Future<void> _scanDocument() async {
    try {
      List<String> pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (pictures.isEmpty) {
        toast('No se capturó ninguna imagen');
        return;
      }

      setState(() {
        _capturedImage = File(pictures.first);
      });

      toast('Imagen capturada con éxito');
    } catch (e) {
      toast('Error al escanear documento: $e', bgColor: Colors.red);
    }
  }

  /// Función para subir una imagen con nota al servidor
  Future<void> _uploadImage() async {
    if (_capturedImage == null || _nota.isEmpty) {
      toast('Debe capturar una imagen y escribir una nota');
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final secureUrl =
          await _uploadImageService.uploadImage(XFile(_capturedImage!.path));

      await _documentoService.postDocumento(
        url: secureUrl,
        nota: _nota,
        tratamiento_id: widget.tratamiento.id!,
      );

      setState(() {
        _documentos.add(DocumentoModel(
          url: secureUrl,
          nota: _nota,
          fecha: DateTime.now().toIso8601String(),
        ));
        _capturedImage = null;
        _nota = '';
      });

      toast('Documento subido con éxito');
    } catch (e) {
      toast('Error al subir la imagen: $e', bgColor: Colors.red);
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
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
      body: Stack(
        children: [
          SingleChildScrollView(
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

                const Divider(height: 24, thickness: 1),

                // Imagen capturada y formulario para subir
                if (_capturedImage != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Imagen Capturada:', style: boldTextStyle(size: 16)),
                      const SizedBox(height: 8),
                      Image.file(
                        _capturedImage!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Nota',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        onChanged: (value) => _nota = value,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _uploadImage,
                        icon: const Icon(Icons.cloud_upload),
                        label: const Text('Subir Imagen'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 16),

                // Botón para escanear documento
                ElevatedButton.icon(
                  onPressed: _scanDocument,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Capturar Imagen'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),

          // Indicador de carga al subir imagen
          if (_isUploading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
