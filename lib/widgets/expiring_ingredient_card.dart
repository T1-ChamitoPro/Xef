import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class ExpiringIngredientCard extends StatelessWidget {
  final String ingredient;
  final String days;

  const ExpiringIngredientCard({
    super.key,
    required this.ingredient,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.warning_amber_rounded)),
        title: Text(
          ingredient,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Vence en $days',
          style: const TextStyle(color: AppColors.warning),
        ),
      ),
    );
  }
}
