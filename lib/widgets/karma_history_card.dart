import 'package:flutter/material.dart';
import 'package:mu/widgets/KarmaItemCard.dart';

class KarmaHistoryCard extends StatefulWidget {
  const KarmaHistoryCard({super.key});

  @override
  State<KarmaHistoryCard> createState() => _KarmaHistoryCardState();
}

class _KarmaHistoryCardState extends State<KarmaHistoryCard> {
  // State variable to control the switch
  bool _hideDailyChatKarma = false;

  @override
  Widget build(BuildContext context) {
    // Dummy data for the list of cards
    final List<Map<String, String>> karmaData = [
      {
        'karma': '1',
        'label': 'Karma',
        'awardedFor': '#Chat Karma',
        'timeAgo': '4 months ago'
      },
      {
        'karma': '200',
        'label': 'Karma',
        'awardedFor': '#Introduction to Markdown',
        'timeAgo': '1 month ago'
      },
      {
        'karma': '50',
        'label': 'Karma',
        'awardedFor': '#Code Generation',
        'timeAgo': '2 weeks ago'
      },
      {
        'karma': '10',
        'label': 'Karma',
        'awardedFor': '#HTML/CSS Mastery',
        'timeAgo': '3 days ago'
      },
      {
        'karma': '5',
        'label': 'Karma',
        'awardedFor': '#User Experience',
        'timeAgo': 'Just now'
      },
    ];

    // Filter the list if the switch is on
    final List<Map<String, String>> displayedKarma = _hideDailyChatKarma
        ? karmaData.where((item) => item['awardedFor'] != '#Chat Karma').toList()
        : karmaData;

    return Container(
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top section with toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hide daily chat karma',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
              Switch(
                value: _hideDailyChatKarma,
                onChanged: (bool value) {
                  setState(() {
                    _hideDailyChatKarma = value;
                  });
                },
                activeColor: const Color(0xFF3B82F6),
                inactiveThumbColor: const Color(0xFFCBD5E1),
                inactiveTrackColor: const Color(0xFFE2E8F0),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          // Scrollable cards section
          Expanded(
            child: ListView.builder(
              itemCount: displayedKarma.length,
              itemBuilder: (context, index) {
                final item = displayedKarma[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: KarmaItemCard(
                    karma: item['karma']!,
                    label: item['label']!,
                    awardedFor: item['awardedFor']!,
                    timeAgo: item['timeAgo']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}