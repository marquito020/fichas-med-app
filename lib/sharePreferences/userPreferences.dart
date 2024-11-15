// import 'package:medilab_prokit/model/auth.dart';

import 'package:fichas_med_app/model/AuthModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();
  late SharedPreferences _prefs;

  factory UserPreferences() => _instance;

  UserPreferences._internal();

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get prefsUser => _prefs;

  String get token => _prefs.getString('token') ?? '';
  int get id => _prefs.getInt('id') ?? 0;
  String get nombre => _prefs.getString('nombre') ?? '';
  String get email => _prefs.getString('email') ?? '';
  String get role => _prefs.getString('role') ?? '';
  bool get isLogged => _prefs.getBool('isLogged') ?? false;

  set token(String token) => _prefs.setString('token', token);
  set id(int id) => _prefs.setInt('id', id);
  set nombre(String nombre) => _prefs.setString('nombre', nombre);
  set email(String email) => _prefs.setString('email', email);
  set role(String role) => _prefs.setString('role', role);
  set isLogged(bool isLogged) => _prefs.setBool('isLogged', isLogged);

  static void saveUserPreferences(AuthModel data) {
    final prefs = UserPreferences();
    prefs.token = data.token!;
    prefs.id = data.id!;
    prefs.nombre = data.nombre!;
    prefs.email = data.apellido!;
    prefs.role = data.role!.nombre!;
    prefs.isLogged = true;
  }

  void clearUser() {
    _prefs.setString('token', '');
    _prefs.setInt('id', 0);
    _prefs.setString('nombre', '');
    _prefs.setString('email', '');
    _prefs.setString('role', '');
    _prefs.setBool('isLogged', false);
  }
}
