import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.yellow,
      titleTextStyle: TextStyle(
          color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w700)),
  scaffoldBackgroundColor: Colors.black.withOpacity(0.8),
  dividerColor: Colors.red,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  textTheme: TextTheme(
      bodyMedium: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
      labelSmall: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.w800,
          fontSize: 14)),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
);
