import 'package:fichas_med_app/config/dio_config.dart';
import 'package:fichas_med_app/model/EspecialidadModel.dart';

class EspecialidadService {
  //Get all especialidades
  Future<List<EspecialidadModel>> getAllEspecialidades() async {
    try {
      final response =
          await DioConfig.dioWithAuthorization.get('/salud/especialidad');
      List<EspecialidadModel> especialidades = (response.data['data'] as List)
          .map((e) => EspecialidadModel.fromJson(e))
          .toList();
      return especialidades;
    } catch (e) {
      throw Exception(e);
    }
  }
}
