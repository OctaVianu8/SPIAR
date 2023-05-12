import 'package:flutter/material.dart';

import 'configurescreen.dart';
import 'homescreen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'S.P.I.A.R.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        '/configure': (context) => ConfigureScreen(),
      },
    );
  }
}
