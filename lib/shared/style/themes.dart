import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
ThemeData lightMode = ThemeData(
  primarySwatch: Colors.blue, // تغيير لون الزراير في الابلكيشن
  fontFamily: 'Jannah',
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.lightButton,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  AppBarTheme(
      titleSpacing: 20.0, // للتحكم فال status bar
      systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness : Brightness.dark
      ),
      backgroundColor: AppColors.lightAppBar,
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
      ),

  ),
  textTheme: TextTheme(
    bodyText1: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
    ),
    caption: const TextStyle(
      color: Colors.white,
      fontSize: 15
    ),
      bodyText2: const TextStyle(
          color: Colors.black,
          fontSize: 20,
      ),
      headline3: TextStyle(
          color: Colors.black.withOpacity(0.7)
      ),
  ) ,
    radioTheme: RadioThemeData(
      fillColor:   MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            return Colors.grey ;
          }),
    ),
  iconTheme: const IconThemeData(
    color: Colors.black
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white
  ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            primary: AppColors.lightButton.withAlpha(200)
        )
    ),
);



//Dark Mode
ThemeData darkMode = ThemeData(
  drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.darkScaffold
  ),
  primarySwatch: Colors.blue, // تغيير لون الزراير في الابلكيشن
    fontFamily: 'Jannah',
    floatingActionButtonTheme: const FloatingActionButtonThemeData(

    backgroundColor: Color(0xffF1B401),
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: const Color(0xff282828),
  appBarTheme:  AppBarTheme(
    titleSpacing: 20.0, // للتحكم فال status bar
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.darkAppBar,
        statusBarIconBrightness : Brightness.light,
    ),

    backgroundColor: AppColors.darkAppBar,
    elevation: 0.0,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 30.0,
    ),
  ),


  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
    ),
    caption: TextStyle(
        color: Colors.white,
        fontSize: 15
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    headline3: TextStyle(
      color: Colors.white
    ),
  ) ,

  radioTheme: RadioThemeData(
    fillColor:   MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Colors.white ;
        }),
  ),
  iconTheme: const IconThemeData(
      color: Colors.white
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Colors.amber,
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.amber
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
          color: Colors.amber,
      ),
    ),
  ),
);