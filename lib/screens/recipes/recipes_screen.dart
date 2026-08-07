import 'package:flutter/material.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Recetas',
        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
      ),
    );
  }
}
