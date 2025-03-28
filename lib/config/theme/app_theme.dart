// impm
import 'package:flutter/material.dart';


const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {

  final int selectedColor;
  final bool isDarkmode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkmode = true
  }) : assert( selectedColor >= 0, 'selected color must be greater than 0' ),
       assert( selectedColor < colorList.length, 'selected color must be less or equal than ${colorList.length - 1}' );

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorList[ selectedColor ],
    appBarTheme: const AppBarTheme(
      centerTitle: false
    )
  );

  //🔥 esto se hace con la finalidad de no remover el `final`
  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkmode
  }) => AppTheme(
    selectedColor: selectedColor ?? this.selectedColor,
    isDarkmode: isDarkmode ?? this.isDarkmode,
  );
} 
