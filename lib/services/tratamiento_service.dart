import 'package:fichas_med_app/config/dio_config.dart';
import 'package:fichas_med_app/model/TratamientoModel.dart';

class TratamientoService {
  // Post a tratamiento
  Future<void> postTratamiento(
      {required String titulo,
      required String detalle,
      required String receta,
      required int historiaClinica_id}) async {
    try {
      final response = await DioConfig.dioWithAuthorization
          .post('/salud/tratamientos', data: {
        'titulo': titulo,
        'detalle': detalle,
        'receta': receta,
        'historiaClinica_id': historiaClinica_id
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
