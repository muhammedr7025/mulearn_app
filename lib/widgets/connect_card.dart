import 'package:flutter/material.dart';

class _ConnectWithMeCardState extends State<ConnectWithMeCard> {
  bool _isEditing = false;
  
  // List of all social profiles with mock data
  final List<_SocialProfile> profiles = [
    _SocialProfile(icon: Icons.code, iconColor: Colors.black, label: "GitHub", username: "jishnu-ms"),
    _SocialProfile(icon: Icons.facebook, iconColor: Colors.blue, label: "Facebook", username: ""), // Empty username
    _SocialProfile(icon: Icons.camera_alt, iconColor: Colors.red, label: "Instagram", username: "jishnu_I"),
    _SocialProfile(icon: Icons.line_axis_sharp, iconColor: Colors.blue, label: "LinkedIn", username: "jishnums830"),
    _SocialProfile(icon: Icons.sports_basketball, iconColor: Colors.pink, label: "Dribbble", username: ""), // Empty username
    _SocialProfile(icon: Icons.brush, iconColor: Colors.blueGrey, label: "Behance", username: ""),
    _SocialProfile(icon: Icons.code, iconColor: Colors.orange, label: "Stack Overflow", username: "stackoverflow username"),
    _SocialProfile(icon: Icons.article, iconColor: Colors.green, label: "Medium", username: "medium username"),
    _SocialProfile(icon: Icons.leaderboard, iconColor: Colors.green, label: "Hackerrank", username: "hackerrank username"),
  ];

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
            // ===== Header Row =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Connect with me",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  icon: Icon(
                    _isEditing ? Icons.check : Icons.edit_outlined,
                    color: _isEditing ? Colors.blue : const Color(0xFF666666),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ===== Conditional content based on editing state =====
            if (_isEditing) ...[
              // --- Editable view with text fields ---
              ...profiles.map((profile) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      _socialIcon(profile.icon),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: profile.label,
                          ),
                          controller: TextEditingController(text: profile.username),
                          onChanged: (newValue) {
                            profile.username = newValue;
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ] else ...[
              // --- Non-editable view with just icons and usernames ---
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: profiles
                    .where((profile) => profile.username.isNotEmpty) // Filter out profiles with empty usernames
                    .map((profile) {
                  return InkWell(
                    onTap: () {
                      // TODO: Handle navigation to the social profile
                    },
                    child: _socialIcon(profile.icon),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// A reusable widget for the social icons
Widget _socialIcon(IconData icon) => Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F2FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.blue),
    );


// Helper class to represent a social media profile
class _SocialProfile {
  final IconData icon;
  final Color iconColor;
  final String label;
  String username;
  
  _SocialProfile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.username,
  });
}

// The main card widget, now a StatefulWidget to manage the editing state
class ConnectWithMeCard extends StatefulWidget {
  const ConnectWithMeCard({super.key});

  @override
  State<ConnectWithMeCard> createState() => _ConnectWithMeCardState();
}