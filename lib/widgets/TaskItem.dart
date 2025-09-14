
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final int karma;
  final bool isCompleted;

  const TaskItem({
    super.key,
    required this.title,
    required this.karma,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: isCompleted,
            onChanged: (bool? value) {},
            activeColor: const Color(0xFF22C55E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                color: isCompleted ? const Color(0xFF9CA3AF) : const Color(0xFF1F2937),
              ),
            ),
          ),
          Text(
            '$karma x',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }
}