
import 'package:flutter/material.dart';
class ShareProfileDialog extends StatefulWidget {
  const ShareProfileDialog({super.key});

  @override
  State<ShareProfileDialog> createState() => _ShareProfileDialogState();
}

class _ShareProfileDialogState extends State<ShareProfileDialog> {
  bool isPublicProfile = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Share your profile"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Switch to public profile"),
              Switch(
                value: isPublicProfile,
                onChanged: (bool newValue) {
                  setState(() {
                    isPublicProfile = newValue;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Handle download certificate
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text("Download Certificate"),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Cancel"),
            ),
          ),
        ],
      ),
    );
  }
}



