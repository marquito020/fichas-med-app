// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:fichas_med_app/utils/MLColors.dart';
// import 'package:nb_utils/nb_utils.dart';

// class AppThemeData {
//   //
//   AppThemeData._();

//   static final ThemeData lightTheme = ThemeData(
//     scaffoldBackgroundColor: whiteColor,
//     primaryColor: appColorPrimary,
//     primaryColorDark: appColorPrimary,
//     /* errorColor: Colors.red, */
//     hoverColor: Colors.white54,
//     dividerColor: viewLineColor,
//     fontFamily: GoogleFonts.openSans().fontFamily,
//     appBarTheme: AppBarTheme(
//       color: white,
//       iconTheme: IconThemeData(color: textPrimaryColor),
//       systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
//     ),
//     textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
//     colorScheme: ColorScheme.light(primary: appColorPrimary),
//     cardTheme: CardTheme(color: Colors.white),
//     cardColor: Colors.white,
//     iconTheme: IconThemeData(color: textPrimaryColor),
//     bottomSheetTheme: BottomSheetThemeData(backgroundColor: whiteColor),
//     textTheme: TextTheme(
//       labelLarge: TextStyle(color: appColorPrimary),
//       titleLarge: TextStyle(color: textPrimaryColor),
//       titleSmall: TextStyle(color: textSecondaryColor),
//     ),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//   ).copyWith(
//     pageTransitionsTheme: PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
//       TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
//       TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//       TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
//       TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
//     }),
//   );

//   static final ThemeData darkTheme = ThemeData(
//     scaffoldBackgroundColor: appBackgroundColorDark,
//     highlightColor: appBackgroundColorDark,
//     /* errorColor: Color(0xFFCF6676), */
//     appBarTheme: AppBarTheme(
//       color: appBackgroundColorDark,
//       iconTheme: IconThemeData(color: blackColor),
//       systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
//     ),
//     primaryColor: color_primary_black,
//     dividerColor: Color(0xFFDADADA).withOpacity(0.3),
//     primaryColorDark: color_primary_black,
//     textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
//     hoverColor: Colors.black12,
//     fontFamily: GoogleFonts.openSans().fontFamily,
//     bottomSheetTheme: BottomSheetThemeData(backgroundColor: appBackgroundColorDark),
//     primaryTextTheme: TextTheme(titleLarge: primaryTextStyle(color: Colors.white), labelSmall: primaryTextStyle(color: Colors.white)),
//     cardTheme: CardTheme(color: cardBackgroundBlackDark),
//     cardColor: appSecondaryBackgroundColor,
//     iconTheme: IconThemeData(color: whiteColor),
//     textTheme: TextTheme(
//       labelLarge: TextStyle(color: color_primary_black),
//       titleLarge: TextStyle(color: whiteColor),
//       titleSmall: TextStyle(color: Colors.white54),
//     ),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//     colorScheme: ColorScheme.dark(primary: appBackgroundColorDark, onPrimary: cardBackgroundBlackDark).copyWith(secondary: whiteColor),
//   ).copyWith(
//     pageTransitionsTheme: PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
//       TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
//       TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//       TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
//       TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
//     }),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class AppThemeData {
  //
  AppThemeData._();

  // Colores base para una clínica general
  static const Color primaryColor = Colors.blueAccent;
  static const Color accentColor = Colors.cyan;
  static const Color backgroundColor = Color(0xFFF9F9F9);
  static const Color cardColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    primaryColorDark: primaryColor,
    hoverColor: Colors.blue[100],
    dividerColor: Colors.grey[300],
    fontFamily: GoogleFonts.openSans().fontFamily,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: primaryColor),
      titleTextStyle: const TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white, // Color del texto
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    cardTheme: const CardTheme(color: cardColor, elevation: 3),
    textTheme: TextTheme(
      labelLarge: const TextStyle(color: primaryColor),
      titleLarge:
          TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
      titleSmall: TextStyle(color: Colors.grey[600]),
    ),
    colorScheme: const ColorScheme.light(primary: primaryColor)
        .copyWith(secondary: accentColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      color: Colors.grey[850],
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    cardTheme: CardTheme(color: Colors.grey[800], elevation: 3),
    textTheme: TextTheme(
      labelLarge: const TextStyle(color: primaryColor),
      titleLarge:
          TextStyle(color: Colors.grey[300], fontWeight: FontWeight.bold),
      titleSmall: TextStyle(color: Colors.grey[500]),
    ),
    colorScheme: ColorScheme.dark(primary: primaryColor)
        .copyWith(secondary: accentColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
