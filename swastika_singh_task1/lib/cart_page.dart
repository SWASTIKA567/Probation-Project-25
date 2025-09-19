import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart Page"), backgroundColor: Colors.purple),
      body: Center(
        child: Text(
          "Your cart is empty 🛒",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.purple[800],
          ),
        ),
      ),
    );
  }
}
