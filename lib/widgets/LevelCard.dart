import 'package:flutter/material.dart';
import 'package:mu/widgets/TaskItem.dart';
class LevelCard extends StatelessWidget {
  final String level;
  final int progress;
  final int total;
  final List<dynamic> tasks;

  const LevelCard({
    super.key,
    required this.level,
    required this.progress,
    required this.total,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final int completedTasks = tasks.where((task) => task['isCompleted']).length;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ExpansionTile(
        title: Row(
          children: [
            Text(
              level,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '[$progress/$total]',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: completedTasks > 0 ? const Color(0xFF22C55E) : const Color(0xFFE2E8F0),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '$completedTasks Tasks',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4B5563),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
        children: tasks.map<Widget>((task) {
          return TaskItem(
            title: task['title'],
            karma: task['karma'],
            isCompleted: task['isCompleted'],
          );
        }).toList(),
      ),
    );
  }
}