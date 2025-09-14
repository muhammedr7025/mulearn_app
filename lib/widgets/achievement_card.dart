import 'package:flutter/material.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Eligible Achievements',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 24.0),
              // This function now returns a card with the badge, title, subtitle, and button
              _buildAchievementItem(
                'assets/images/img1.png', // <-- Use your local image path here
                'Level 4 Badge',
                'Completed Level 4.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // A helper function to build a single achievement item
  Widget _buildAchievementItem(
    String imagePath,
    String title,
    String subtitle,
  ) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // The large badge image
            Image.asset(
              imagePath,
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 24.0),
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4.0),
            // Subtitle
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black, // Changed to black
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Handle 'Issue VC' tap
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text('Issue VC'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}