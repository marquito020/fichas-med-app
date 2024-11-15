import 'package:fichas_med_app/screens/DoctorHistorialClinicoScreen.dart';
import 'package:fichas_med_app/screens/HistorialClinicoScreen.dart';
import 'package:fichas_med_app/screens/MisReservasScreen.dart';
import 'package:fichas_med_app/screens/ProfileScreen.dart';
import 'package:fichas_med_app/sharePreferences/userPreferences.dart';
import 'package:flutter/material.dart';
import 'package:fichas_med_app/components/MLBottomNavigationBarWidget.dart';
// import 'package:fichas_med_app/fragments/MLCalendarFragment.dart';
// import 'package:fichas_med_app/fragments/MLChatFragment.dart';
import 'package:fichas_med_app/fragments/MLHomeFragment.dart';
// import 'package:fichas_med_app/fragments/MLNotificationFragment.dart';
// import 'package:fichas_med_app/fragments/MLProfileFragemnt.dart';
import 'package:fichas_med_app/utils/MLColors.dart';
import 'package:fichas_med_app/utils/MLCommon.dart';

class MLDashboardScreen extends StatefulWidget {
  static String tag = '/MLDashboardScreen';
  @override
  _MLDashboardScreenState createState() => _MLDashboardScreenState();
}

class _MLDashboardScreenState extends State<MLDashboardScreen> {
  int currentWidget = 0;
  final prefs = UserPreferences();
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    init();
    widgets = [
      MLHomeFragment(),
      if (prefs.role != 'DOCTOR') const MisReservasScreen(),
      if (prefs.role != 'DOCTOR') HistorialClinicoScreen(),
      if (prefs.role == 'DOCTOR') DoctorHistorialClinicoScreen(),
      ProfileScreen(),
      // MLChatFragment(),
      // MLCalendarFragment(),
      // MLNotificationFragment(),
      // MLProfileFragment(),
    ];
  }

  Future<void> init() async {
    //
  }
  @override
  void dispose() {
    changeStatusColor(mlPrimaryColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widgets[currentWidget],
        bottomNavigationBar:
            Container(color: Colors.white, child: showBottomDrawer()),
      ),
    );
  }

  Widget showBottomDrawer() {
    return MLBottomNavigationBarWidget(
      index: currentWidget,
      onTap: (index) {
        setState(() {});
        currentWidget = index;
      },
    );
  }
}
