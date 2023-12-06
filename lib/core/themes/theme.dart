import 'package:flutter/material.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: Colors.grey[150],

      fontFamily: 'OpenSans Bold',
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans Bold'

              )
          )
      )
  );
}