import 'package:flutter/material.dart';
import 'package:mu/widgets/LevelCard.dart'; // import your LevelCard widget

class LevelCardList extends StatelessWidget {
  const LevelCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> levelData = [
      {
        'level': 'lvl1',
        'progress': 20,
        'total': 120,
        'tasks': [
          {'title': 'Self Introduction', 'karma': 20, 'isCompleted': true},
          {'title': 'Discord Guide', 'karma': 100, 'isCompleted': false},
        ],
      },
      {
        'level': 'lvl2',
        'progress': 700,
        'total': 7080,
        'tasks': [],
      },
      {
        'level': 'lvl3',
        'progress': 1000,
        'total': 17340,
        'tasks': [],
      },
      {
        'level': 'lvl4',
        'progress': 0,
        'total': 76400,
        'tasks': [],
      },
      {
        'level': 'lvl5',
        'progress': 0,
        'total': 10100,
        'tasks': [],
      },
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      // Use a Column to stack the image and the list
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The single image and text at the top-left
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // The badge image
                Image.asset(
                  'assets/images/img1.png', // <--- Your image path
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 12),
                // The level text
                const Text(
                  'lvl4',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          // The list of all your level cards
          ListView.builder(
            shrinkWrap: true,
            itemCount: levelData.length,
            itemBuilder: (context, index) {
              final level = levelData[index];
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: LevelCard(
                  level: level['level'],
                  progress: level['progress'],
                  total: level['total'],
                  tasks: level['tasks'],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}