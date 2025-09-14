import 'package:flutter/material.dart';


class KarmaItemCard extends StatelessWidget {
  final String karma;
  final String label;
  final String awardedFor;
  final String timeAgo;

  const KarmaItemCard({
    super.key,
    required this.karma,
    required this.label,
    required this.awardedFor,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                karma,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3B82F6),
                ),
              ),
              const Text(
                'x',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3B82F6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Awarded for',
            style: TextStyle(
              fontSize: 14.0,
              color: const Color(0xFF6B7280).withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            awardedFor,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFF3B82F6),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            timeAgo,
            style: TextStyle(
              fontSize: 12.0,
              color: const Color(0xFF9CA3AF).withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}