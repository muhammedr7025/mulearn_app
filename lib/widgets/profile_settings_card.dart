import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileSettingsCard extends StatefulWidget {
  const ProfileSettingsCard({super.key});

  @override
  State<ProfileSettingsCard> createState() => _ProfileSettingsCardState();
}

class _ProfileSettingsCardState extends State<ProfileSettingsCard> {
  bool isPublicProfile = false;
  bool isOpenToWork = false;
  bool isOpenToGigs = false;

  @override
  Widget build(BuildContext context) {
    return Card(
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
            const Text(
              "Profile Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Switch to public profile
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Switch to public profile",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4C87F5),
                  ),
                ),
                CupertinoSwitch(
                  value: isPublicProfile,
                  activeColor: const Color(0xFF4C87F5),
                  onChanged: (bool newValue) {
                    setState(() {
                      isPublicProfile = newValue;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Open to work
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Open to work",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4C87F5),
                  ),
                ),
                CupertinoSwitch(
                  value: isOpenToWork,
                  activeColor: const Color(0xFF4C87F5),
                  onChanged: (bool newValue) {
                    setState(() {
                      isOpenToWork = newValue;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Open to gigs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Open to gigs",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4C87F5),
                  ),
                ),
                CupertinoSwitch(
                  value: isOpenToGigs,
                  activeColor: const Color(0xFF4C87F5),
                  onChanged: (bool newValue) {
                    setState(() {
                      isOpenToGigs = newValue;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}