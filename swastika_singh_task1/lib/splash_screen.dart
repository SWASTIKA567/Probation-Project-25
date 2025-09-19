import 'package:flutter/material.dart';
import 'home_page.dart'; //  HomePage import

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 3 second baad HomePage khul jaayega
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.purple[100], // halka purple background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 80, color: Colors.purple),
            SizedBox(height: 20),
            Text(
              "Twilight",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.purple[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
