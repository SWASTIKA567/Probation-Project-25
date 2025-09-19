import 'package:flutter/material.dart';

import 'splash_screen.dart'; //  Splash screen import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Twilight",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: SplashScreen(), //  App start hote hi Splash chalega
    );
  }
}
