import 'package:flutter/material.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Compras',
        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
      ),
    );
  }
}
