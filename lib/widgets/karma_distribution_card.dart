import 'package:flutter/material.dart';

Widget karmaDistributionCard() => Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Combined horizontal scrollable for months and grid
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Month labels
                  Row(
                    children: [
                      const SizedBox(width: 30), // Align with day labels
                      ...[
                        "Jan",
                        "Feb",
                        "Mar",
                        "Apr",
                        "May",
                        "Jun",
                        "Jul",
                        "Aug",
                        "Sep",
                        "Oct",
                        "Nov",
                        "Dec"
                      ].map((m) => SizedBox(
                            width: 53,
                            child: Text(m,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          )),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Calendar grid
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Day labels
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mon", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 18),
                          Text("Wed", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 18),
                          Text("Fri", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(width: 8),

                      // Grid squares
                      Row(
                        children: List.generate(53, (week) {
                          return Column(
                            children: List.generate(7, (day) {
                              int index = week * 7 + day;
                              Color color = const Color(0xFFE8F5E9);
                              if (index == 78) color = const Color(0xFF4CAF50);
                              return Container(
                                width: 12,
                                height: 12,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              );
                            }),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Year selector at bottom center
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['2024', '2025'].map((year) {
                final isSelected = year == '2025'; // Replace with state variable if needed
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      year,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
