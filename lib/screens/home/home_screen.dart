import 'package:flutter/material.dart';

import '../../widgets/home_header.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/cook_suggestion_card.dart';
import '../../widgets/recipe_card.dart';
import '../../widgets/expiring_ingredient_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),

            const SizedBox(height: 24),

            const XefSearchBar(),

            const SizedBox(height: 24),

            const CookSuggestionCard(),

            const SizedBox(height: 28),

            const Text(
              'Recetas para ti',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  RecipeCard(
                    name: 'Pasta cremosa',
                    emoji: '🍝',
                    time: '25 min',
                  ),
                  SizedBox(width: 12),
                  RecipeCard(
                    name: 'Pollo al horno',
                    emoji: '🍗',
                    time: '40 min',
                  ),
                  SizedBox(width: 12),
                  RecipeCard(
                    name: 'Arroz especial',
                    emoji: '🍚',
                    time: '30 min',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Ingredientes por vencer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            const ExpiringIngredientCard(ingredient: 'Tomate', days: '2 días'),

            const ExpiringIngredientCard(ingredient: 'Leche', days: '3 días'),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
