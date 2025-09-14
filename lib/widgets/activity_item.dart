import 'package:flutter/material.dart';

Widget buildActivityItem(String activityText, String timeStamp) {
  // Split the number from the rest of the text
  final match = RegExp(r'^\d+').firstMatch(activityText);
  String number = '';
  String restText = activityText;

  if (match != null) {
    number = match.group(0)!;
    restText = activityText.substring(number.length);
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
    child: Row(
      children: [
       CircleAvatar(
  backgroundColor: Colors.transparent, // optional, if you want no bg color
  radius: 20, // optional, adjust size
  child: ClipOval(
    child: Image.asset(
      'assets/images/img2.png', // your local image path
      fit: BoxFit.cover,
      width: 40, // match the CircleAvatar radius
      height: 40,
    ),
  ),
),
        const SizedBox(width: 12),
        // Activity text and timestamp
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: number,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue, // number in blue
                      ),
                    ),
                    TextSpan(
                      text: restText,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C3E50), // dark grey
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                timeStamp,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
