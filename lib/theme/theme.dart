import 'package:flutter/material.dart';

final aquationTheme = ThemeData(
  useMaterial3: true,
  colorScheme:
      ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ).copyWith(
        onPrimary: const Color.fromARGB(255, 231, 231, 231),
        primaryFixed: Colors.blue.shade300,
      ),
);
