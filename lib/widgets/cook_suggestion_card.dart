import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class CookSuggestionCard extends StatelessWidget {
  const CookSuggestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.restaurant, color: Colors.white, size: 32),

          const SizedBox(height: 12),

          const Text(
            '¿Qué puedo cocinar?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Descubre recetas usando los ingredientes que tienes.',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),

          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              minimumSize: const Size(130, 45),
            ),
            child: const Text('Descubrir'),
          ),
        ],
      ),
    );
  }
}
