import 'package:fichas_med_app/model/AuthModel.dart';
import 'package:fichas_med_app/config/dio_config.dart';
import 'package:fichas_med_app/sharePreferences/userPreferences.dart';

class AuthService {
  //Login
  Future<void> login({required String email, required String password}) async {
    try {
      final response = await DioConfig.dioWithoutAuthorization
          .post('/salud/auth/login', data: {
        'username': email,
        'password': password,
      });
      AuthModel authModel = AuthModel.fromJson(response.data);
      print(authModel);
      UserPreferences.saveUserPreferences(authModel);
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
