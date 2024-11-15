import 'package:fichas_med_app/config/dio_config.dart';
import 'package:fichas_med_app/model/HorarioModel.dart';

class HorarioService {
  //Get all horarios
  Future<List<HorarioModel>> getAllHorarios() async {
    try {
      final response =
          await DioConfig.dioWithAuthorization.get('/salud/horarios');
      List<HorarioModel> horarios = (response.data['data'] as List)
          .map((e) => HorarioModel.fromJson(e))
          .toList();
      return horarios;
    } catch (e) {
      throw Exception(e);
    }
  }
}
