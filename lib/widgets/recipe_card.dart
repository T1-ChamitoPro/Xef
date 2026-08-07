import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String name;
  final String emoji;
  final String time;

  const RecipeCard({
    super.key,
    required this.name,
    required this.emoji,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              width: double.infinity,
              color: Colors.orange.shade100,
              alignment: Alignment.center,
              child: Text(emoji, style: const TextStyle(fontSize: 50)),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '⏱ $time',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
