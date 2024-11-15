import 'package:fichas_med_app/sharePreferences/userPreferences.dart';
import 'package:flutter/material.dart';
import 'package:fichas_med_app/utils/MLCommon.dart';

class MLBottomNavigationBarWidget extends StatefulWidget {
  static String tag = '/MLBottomNavigationBarWidget';
  final Function(int)? onTap;
  final int? index;
  MLBottomNavigationBarWidget({this.onTap, this.index});
  @override
  MLBottomNavigationBarWidgetState createState() =>
      MLBottomNavigationBarWidgetState();
}

class MLBottomNavigationBarWidgetState
    extends State<MLBottomNavigationBarWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final prefs = UserPreferences();
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey.shade400,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontSize: 0),
      unselectedLabelStyle: TextStyle(fontSize: 0),
      currentIndex: widget.index!,
      onTap: widget.onTap,
      items: [
        bottomNavigationItem(Icons.home_outlined),
        if (prefs.role != 'DOCTOR')
          bottomNavigationItem(Icons.chat_bubble_outline),
        if (prefs.role != 'DOCTOR')
          bottomNavigationItem(Icons.calendar_today_outlined),
        // bottomNavigationItem(Icons.notifications_none),
        if (prefs.role == 'DOCTOR')
          bottomNavigationItem(Icons.calendar_today_outlined),
        bottomNavigationItem(Icons.people_alt_outlined),
      ],
    );
  }

  bottomNavigationItem(IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 22),
      label: '',
      activeIcon: mlSelectedNavigationbarIcon(icon),
    );
  }
}
