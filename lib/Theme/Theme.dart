import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData ui = new ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.blueGrey,
  );
  static LinearGradient gradient = LinearGradient(
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp,
    begin: Alignment(0.0, -1.0),
    end: Alignment(0.0, 0.6),
    colors: <Color>[
      const Color(0xFF3366FF),
      const Color(0xFF00CCFF),
    ],
  );
}
