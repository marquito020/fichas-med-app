import 'package:fichas_med_app/model/EspecialidadModel.dart';
import 'package:fichas_med_app/screens/EspecialidadesScreen.dart';
import 'package:fichas_med_app/screens/MLDashboardScreen.dart';
import 'package:fichas_med_app/screens/MLHorariosPage.dart';
import 'package:fichas_med_app/screens/MLLoginScreen.dart';
import 'package:fichas_med_app/screens/MLSplashScreen.dart';
import 'package:flutter/material.dart';
import '../sharePreferences/userPreferences.dart';

class Routes {
  static const String dashboard = '/dashboard';
  static const String login = '/login';
  static const String communication = '/communication';
  static const String notification = '/notification';
  static const String horarios = '/horarios';
  static const String especialidades = '/especialidades';
}

Map<String, WidgetBuilder> getApplicationRoutes() {
  final prefs = UserPreferences();
  return <String, WidgetBuilder>{
    // Login Route
    Routes.login: (BuildContext context) => MLLoginScreen(),
    // Default Route
    // '/': (BuildContext context) =>
    //     prefs.isLogged ? HomeScreen() : LoginScreen(),
    '/': (BuildContext context) =>
        prefs.isLogged ? MLDashboardScreen() : MLSplashScreen(),
    Routes.dashboard: (BuildContext context) => MLDashboardScreen(),

    // Routes.communication: (BuildContext context) => ComunicadosScreen(),
    // Routes.home: (BuildContext context) => HomeScreen(),
    // Routes.notification: (BuildContext context) => NotificacionesScreen(),
    // '/': (BuildContext context) =>
    //     prefs.isLogged ? MLDashboardScreen() : MLSplashScreen(),
    // Routes.login: (BuildContext context) => MLLoginScreen(),
    // Routes.home: (BuildContext context) => MLDashboardScreen(),
    // Routes.camera: (BuildContext context) => MLCameraScreen(cameras: cameras),
    // Routes.treatment: (BuildContext context) => MLMedicationScreen(),
    // Routes.reservationDoctor: (BuildContext context) =>
    //     MLDoctorReservationsScreen(),

    Routes.horarios: (BuildContext context) {
      final EspecialidadModel especialidad =
          ModalRoute.of(context)!.settings.arguments as EspecialidadModel;
      return MLHorariosScreen(especialidad: especialidad);
    },

    Routes.especialidades: (BuildContext context) => EspecialidadesScreen(),

    // // Patient Detail Route
    // Routes.patientDetail: (BuildContext context) {
    //   final Person patient =
    //       ModalRoute.of(context)!.settings.arguments as Person;
    //   return MLPatientDetailsScreen(patient: patient);
    // },

    // // Certification Route
    // Routes.certification: (BuildContext context) {
    //   final Person patient =
    //       ModalRoute.of(context)!.settings.arguments as Person;
    //   return MLCreateOphthalmologyCertificateScreen(patient: patient);
    // },

    // // Notification Route
    // Routes.notification: (BuildContext context) => MLNotificationScreen(),
  };
}
