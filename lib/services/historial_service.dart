import 'package:fichas_med_app/config/dio_config.dart';
import 'package:fichas_med_app/model/HistorialClinicoModel.dart';
import 'package:fichas_med_app/model/PacienteModel.dart';
import 'package:fichas_med_app/services/paciente_service.dart';
import 'package:fichas_med_app/sharePreferences/userPreferences.dart';

class HistorialService {
  PacienteService pacienteService = PacienteService();
  //get all historiales by paciente id
  Future<List<HistorialClinicoModel>> getAllMyHistoriales() async {
    final prefs = UserPreferences();
    try {
      // Get Pacientes
      List<PacienteModel> pacientes = await pacienteService.getAllPacientes();

      // Comparar id de usuario con pref.id
      final pacienteId = pacientes
          .firstWhere(
            (paciente) =>
                paciente.persona?.usuario?.id != null &&
                paciente.persona!.usuario!.id == prefs.id,
          )
          .id;

      print("PacienteId: $pacienteId");

      final response = await DioConfig.dioWithAuthorization
          .get('/salud/historias-clinicas/paciente/$pacienteId');

      List<HistorialClinicoModel> historiales = (response.data['data'] as List)
          .map((h) => HistorialClinicoModel.fromJson(h))
          .toList();
      return historiales;
    } catch (e) {
      throw Exception(e);
    }
  }

  // get all historial clinico
  Future<List<HistorialClinicoModel>> getAllHistoriales() async {
    try {
      final response = await DioConfig.dioWithAuthorization
          .get('/salud/historias-clinicas');

      List<HistorialClinicoModel> historiales = (response.data['data'] as List)
          .map((h) => HistorialClinicoModel.fromJson(h))
          .toList();
      return historiales;
    } catch (e) {
      throw Exception(e);
    }
  }
}
