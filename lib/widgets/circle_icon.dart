import 'package:flutter/material.dart';

Widget circleIcon(ThemeData theme, IconData icon) {
  return Container(
    decoration: BoxDecoration(
      color: theme.colorScheme.surface,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(10),
    child: Icon(icon, color: theme.colorScheme.primary),
  );
}
