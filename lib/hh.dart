import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';

import 'package:mu/widgets/EditProfileDialog.dart';
import 'package:mu/widgets/KarmaItemCard.dart';
import 'package:mu/widgets/LevelCard.dart';
import 'package:mu/widgets/PieChartPainter.dart';
import 'package:mu/widgets/ShareProfileDialog.dart';
import 'package:mu/widgets/TaskItem.dart';
import 'package:mu/widgets/achievement_card.dart';
import 'package:mu/widgets/achievement_item.dart';
import 'package:mu/widgets/activity_item.dart';
import 'package:mu/widgets/circle_icon.dart';
import 'package:mu/widgets/connect_card.dart';
import 'package:mu/widgets/interest_groups_card.dart';
import 'package:mu/widgets/karma_distribution_card.dart';
import 'package:mu/widgets/karma_history_card.dart';
import 'package:mu/widgets/legend_item.dart';
import 'package:mu/widgets/level_card_list.dart';
import 'package:mu/widgets/profile_settings_card.dart';
import 'package:mu/widgets/recent_activity_card.dart';
import 'package:mu/widgets/reports_card.dart';
import 'package:mu/widgets/stat_card.dart';

class ProfilePge extends StatefulWidget {
  const ProfilePge({super.key});

  @override
  State<ProfilePge> createState() => _ProfilePgeState();
}

class _ProfilePgeState extends State<ProfilePge> {
  // State variables
  String selectedYear = '2025';
  bool isPublicProfile = false;
  bool isOpenToWork = false;
  bool isOpenToGigs = false;
  int selectedTabIndex = 0; // For top tabs

  final List<String> tabs = [
    'Basic Details',
    'Karma History',
    'Mu Voyage',
    'Achievement'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mock data
    const coverUrl =
        'https://images.unsplash.com/photo-1520975916090-3105956dac38?q=80&w=1600';
    const avatarUrl = 'https://i.pravatar.cc/300?img=5';
    const name = 'Jishnu M S (MCE)';
    const email = 'jishnums@mulearn';
    const level = 'LEVEL 4';

    const double avatarRadius = 52;
    const double ringWidth = 6;

    return Scaffold(
      appBar:AppBar(
  title: const Text(''),
  elevation: 0,
  backgroundColor: theme.scaffoldBackgroundColor,
  surfaceTintColor: Colors.transparent,
  leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
  actions: [
    GestureDetector(
      onTap: () {
        _showLogoutWarning(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(avatarUrl),
        ),
      ),
    ),
  ],
),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // ====== Top Profile Card ======
           Card(
             color: Colors.white ,
  elevation: 3,
  clipBehavior: Clip.antiAlias,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // ===== Banner =====
      Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(coverUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // ===== Avatar Centered Over Banner =====
          Positioned(
            bottom: -avatarRadius, // half of avatar overlaps banner
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: avatarRadius * 2 + ringWidth * 2,
                height: avatarRadius * 2 + ringWidth * 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: ringWidth,
                  ),
                ),
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 8), // small gap below avatar

      // ===== Row for avatar space + right-side icons =====
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Spacer(),
      // Edit icon (opens the form)
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const EditProfileDialog();
            },
          );
        },
        child: circleIcon(theme, Icons.edit),
      ),
      const SizedBox(width: 12),
      // Share icon (opens the share dialog)
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ShareProfileDialog();
            },
          );
        },
        child: circleIcon(theme, Icons.share),
      ),
    ],
        ),
      ),

      const SizedBox(height: 16),

      // ===== Name & Email =====
      Text(
        name,
        textAlign: TextAlign.center,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        email,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.hintColor,
        ),
      ),
      const SizedBox(height: 8),

      // ===== Level Badge =====
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            level,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),

      const SizedBox(height: 16),

      // ===== Tabs =====
      SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: tabs.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final isSelected = selectedTabIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tabs[index],
                    style: TextStyle(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 3,
                    width: 30,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

      const SizedBox(height: 16),

      // ===== Stats Row =====
      Row(
        children: [
          Expanded(
            child: statCard(
              context,
              title: 'Karma',
              value: '1.72K',
              icon: Icons.bubble_chart,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: statCard(
              context,
              title: 'Avg.Karma/Month',
              value: '101',
              icon: Icons.percent,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: statCard(
              context,
              title: 'Rank',
              value: '3213',
              icon: Icons.bar_chart,
            ),
          ),
        ],
      ),
      const SizedBox(height: 24),
      statCard(
        context,
        title: 'Percentile',
        value: '5.47',
        icon: Icons.bar_chart,
      ),
      const SizedBox(height: 8),
    ],
  ),
),

              const SizedBox(height: 16),

              // ===== Rest of the cards remain the same =====
                 _buildDynamicCard(),
              const SizedBox(height: 16),
             
              
              
              ProfileSettingsCard(),
              const SizedBox(height: 16),
              ConnectWithMeCard(),
              const SizedBox(height: 16),
              _existingRolesCard(),
              const SizedBox(height: 16),
               reportsCard(),
              const SizedBox(height: 16),
              recentActivityCard(),
              const SizedBox(height: 16),
              
            ],
          ),
        ),
      ),
    );
  }

  // ===== Helper Widgets =====




  // ===== Dynamic Card Builder =====
  Widget _buildDynamicCard() {
    switch (selectedTabIndex) {
   case 0:
  return Column(
    children: [
      InterestGroupsCard(),
      karmaDistributionCard(),
    ],
  );

        

      case 1:
        return KarmaHistoryCard();
      case 2:
        return LevelCardList();
      case 3:
        return AchievementCard();
      default:
        return SizedBox.shrink();
    }
  }





 


  Widget _existingRolesCard() =>   SizedBox(
   
                width: double.infinity,
                child: Card(
                   color: Colors.white ,
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
                          "Existing Roles",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Student",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4C87F5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
 
}


class _PieChartPainter extends CustomPainter {
  const _PieChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    double radius = 1;
    radius = math.min(size.width / 2, size.height / 2);
    Offset center = Offset(size.width / 2, size.height / 2);

    // Hardcoded angles for the segments (94.6%, Collaboration, Profile Building)
    const double generalEnablementAngle = 0.946 * 2 * math.pi;
    const double collaborationAngle = 0.03 * 2 * math.pi;
    const double profileBuildingAngle = 0.024 * 2 * math.pi;

    // Draw slices
    _drawSlice(
      canvas,
      center,
      radius,
      0,
      generalEnablementAngle,
      const Color(0xFF90CAF9),
    );
    _drawSlice(
      canvas,
      center,
      radius,
      generalEnablementAngle,
      collaborationAngle,
      const Color(0xFF42A5F5),
    );
    _drawSlice(
      canvas,
      center,
      radius,
      generalEnablementAngle + collaborationAngle,
      profileBuildingAngle,
      const Color(0xFF1E88E5),
    );

    // Draw the percentage text for the largest segment
    const double textRadius = 0.7 * 1;
    Offset textCenter = Offset(
      center.dx +
          textRadius * math.cos(generalEnablementAngle / 2 - math.pi / 2),
      center.dy +
          textRadius * math.sin(generalEnablementAngle / 2 - math.pi / 2),
    );

    final textPainter = TextPainter(
      text: const TextSpan(
        text: '94.6%',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      textCenter - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  void _drawSlice(
    Canvas canvas,
    Offset center,
    double radius,
    double startAngle,
    double sweepAngle,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
void _showLogoutWarning(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Logout'),
            onPressed: () {
              // TODO: Implement your logout logic here
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      );
    },
  );
}