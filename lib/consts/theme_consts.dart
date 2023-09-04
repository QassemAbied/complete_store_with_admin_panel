import 'package:flutter/material.dart';

class Style{
  ThemeData themeData(bool isThemeDark, context){
    return ThemeData(
      scaffoldBackgroundColor: isThemeDark ? Colors.white : Colors.black, 
      primaryColor: isThemeDark?  Color(0xFF384358) : Color(0xFFA586),
      cardColor: isThemeDark? Color(0xFF384358) : Color(0xFFA586),
      colorScheme: ThemeData().colorScheme.copyWith(
        secondary: isThemeDark? Color(0xFF384358) : Color(0xFFA586),
        brightness: isThemeDark? Brightness.light: Brightness.dark,
      ),
      canvasColor: isThemeDark? Color(0xFF384358) : Color(0xFFA586),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: isThemeDark? ColorScheme.light(): ColorScheme.light(),
      ),
    );
  }
}