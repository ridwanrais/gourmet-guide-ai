import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/theme_provider.dart';
import 'screens/location_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'GoFood AI',
          theme: themeProvider.getTheme(),
          debugShowCheckedModeBanner: false,
          home: const LocationScreen(),
        );
      },
    );
  }
}
