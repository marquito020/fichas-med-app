import 'package:fichas_med_app/config/dio_config.dart';
import 'package:fichas_med_app/model/PacienteModel.dart';

class PacienteService {
  //Get all pacientes
  Future<List<PacienteModel>> getAllPacientes() async {
    try {
      final response =
          await DioConfig.dioWithAuthorization.get('/salud/pacientes');
      List<PacienteModel> pacientes = (response.data['data'] as List)
          .map((e) => PacienteModel.fromJson(e))
          .toList();
      return pacientes;
    } catch (e) {
      throw Exception(e);
    }
  }
}