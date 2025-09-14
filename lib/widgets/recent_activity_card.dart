import 'package:flutter/material.dart';
import 'activity_item.dart'; // import your buildActivityItem file

Widget recentActivityCard() => Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Header Row with title and View More button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Handle View More tap
                  },
                  child: const Text(
                    "View More",
                    style: TextStyle(
                      color: Color(0xFF4C87F5), // Blue color
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // The list of activity items
            Column(
              children: [
                buildActivityItem(
                  '1 awarded for Chat Karma.',
                  '4 months ago',
                ),
                buildActivityItem(
                  '200 awarded for Introduction to Markdown.',
                  '9 months ago',
                ),
                buildActivityItem(
                  '200 awarded for Introduction to Command line.',
                  '9 months ago',
                ),
                buildActivityItem(
                  '200 awarded for Introduction to GitHub pages.',
                  '9 months ago',
                ),
                buildActivityItem(
                  '200 awarded for Introduction to GitHub pages.',
                  '9 months ago',
                ),
                buildActivityItem(
                  '200 awarded for Mobile Game Deconstruction.',
                  'a year ago',
                ),
                buildActivityItem(
                  '200 awarded for Typing Challenge.',
                  'a year ago',
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Bottom View More link
            TextButton(
              onPressed: () {
                // TODO: Handle bottom View More tap
              },
              child: const Text(
                "View More",
                style: TextStyle(
                  color: Color(0xFF4C87F5), // Blue color
                ),
              ),
            ),
          ],
        ),
      ),
    );
