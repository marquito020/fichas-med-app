import 'package:fichas_med_app/config/dio_config.dart';
import 'package:fichas_med_app/model/DocumentoModel.dart';

class DocumentoService {
  // Post a new documento
  Future<void> postDocumento({
    required String url,
    required String nota,
    required int tratamiento_id,
  }) async {
    try {
      await DioConfig.dioWithAuthorization.post('/salud/documentos', data: {
        'url': url,
        'nota': nota,
        'fecha':
            DateTime.now().toIso8601String(), // Formato compatible ISO 8601
        'tratamiento_id': tratamiento_id,
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
