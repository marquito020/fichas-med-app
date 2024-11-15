import 'package:fichas_med_app/config/dio_config.dart';
import 'package:fichas_med_app/model/PacienteModel.dart';
import 'package:fichas_med_app/model/ReservaModel.dart';
import 'package:fichas_med_app/services/paciente_service.dart';
import 'package:fichas_med_app/sharePreferences/userPreferences.dart';

class ReservaService {
  PacienteService pacienteService = PacienteService();

  // Create reserva
  Future<void> createReserva({
    required int especialidadId,
    required int horarioId,
  }) async {
    final prefs = UserPreferences();
    try {
      // Date time format (2024-11-15)
      final String date = DateTime.now().toIso8601String().split('T').first;

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

      print("Date: $date");
      final response =
          await DioConfig.dioWithAuthorization.post('/salud/reservas', data: {
        'pacienteId': pacienteId,
        'especialidadId': especialidadId,
        'horarioId': horarioId,
        'fechaReserva': date,
      });
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Get all reservas by pacienteId
  Future<List<ReservaModel>> getAllReservasByPacienteId() async {
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
          .get('/salud/reservas/paciente/$pacienteId');
      List<ReservaModel> reservas = (response.data['data'] as List)
          .map((e) => ReservaModel.fromJson(e))
          .toList();
      return reservas;
    } catch (e) {
      throw Exception(e);
    }
  }
}
