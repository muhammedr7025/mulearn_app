import 'package:flutter/material.dart';

// Helper class to represent a single interest chip's data
class _InterestChipData {
  final String text;
  final int count;
  final Color backgroundColor;
  final Color foregroundColor;
  
  _InterestChipData({
    required this.text,
    this.count = 0,
    required this.backgroundColor,
    required this.foregroundColor,
  });
}

// The main card widget, now a StatefulWidget to manage the editing state
class InterestGroupsCard extends StatefulWidget {
  const InterestGroupsCard({super.key});

  @override
  State<InterestGroupsCard> createState() => _InterestGroupsCardState();
}

class _InterestGroupsCardState extends State<InterestGroupsCard> {
  bool _isEditing = false;
  
  // A list of all available chips
  final List<_InterestChipData> allChips = [
    _InterestChipData(text: "Cyber Security", backgroundColor: const Color(0xFFFDE8C7), foregroundColor: const Color.fromARGB(255, 226, 145, 16)),
    _InterestChipData(text: "Ui Ux", backgroundColor: const Color(0xFFFAD1DD), foregroundColor: const Color.fromARGB(255, 233, 86, 130)),
    _InterestChipData(text: "Web Development", backgroundColor: const Color(0xFFCAE7F0), foregroundColor: const Color.fromARGB(255, 84, 190, 222)),
    _InterestChipData(text: "Product Management", backgroundColor: const Color(0xFFFDE8C7), foregroundColor: const Color.fromARGB(255, 226, 145, 16)),
    _InterestChipData(text: "Devops", backgroundColor: const Color(0xFFFAD1DD), foregroundColor: const Color.fromARGB(255, 233, 86, 130)),
    _InterestChipData(text: "Game Dev", backgroundColor: const Color(0xFFCAE7F0), foregroundColor: const Color.fromARGB(255, 84, 190, 222)),
    _InterestChipData(text: "No Or Low Code", backgroundColor: const Color(0xFFCAE7F0), foregroundColor: const Color.fromARGB(255, 84, 190, 222)),
    _InterestChipData(text: "Entrepreneurship", backgroundColor: const Color(0xFFFAD1DD), foregroundColor: const Color.fromARGB(255, 233, 86, 130)),
    _InterestChipData(text: "Ar Vr Mr", backgroundColor: const Color(0xFFCAE7F0), foregroundColor: const Color.fromARGB(255, 84, 190, 222)),
    _InterestChipData(text: "Mobile Development", backgroundColor: const Color(0xFFFAD1DD), foregroundColor: const Color.fromARGB(255, 233, 86, 130)),
    _InterestChipData(text: "Data Analytics", backgroundColor: const Color(0xFFCAE7F0), foregroundColor: const Color.fromARGB(255, 84, 190, 222)),
    _InterestChipData(text: "Space", backgroundColor: const Color(0xFFFAD1DD), foregroundColor: const Color.fromARGB(255, 233, 86, 130)),
    _InterestChipData(text: "Ai", backgroundColor: const Color(0xFFCAE7F0), foregroundColor: const Color.fromARGB(255, 84, 190, 222)),
    _InterestChipData(text: "Comics", backgroundColor: const Color(0xFFFAD1DD), foregroundColor: const Color.fromARGB(255, 233, 86, 130)),
    _InterestChipData(text: "Digital Marketing", backgroundColor: const Color(0xFFCAE7F0), foregroundColor: const Color.fromARGB(255, 84, 190, 222)),
    _InterestChipData(text: "MuV", backgroundColor: const Color(0xFFFAD1DD), foregroundColor: const Color.fromARGB(255, 233, 86, 130)),
    _InterestChipData(text: "Generative Ai", backgroundColor: const Color(0xFFCAE7F0), foregroundColor: const Color.fromARGB(255, 84, 190, 222)),
  ];

  // The chips that are currently selected (initially just the first three)
  late List<_InterestChipData> selectedChips;
  // The chips that are available to be added
  late List<_InterestChipData> availableChips;

  @override
  void initState() {
    super.initState();
    // Initialize the lists for the first time
    selectedChips = allChips.take(3).toList();
    availableChips = allChips.skip(3).toList();
  }

  // --- Helper widgets for chips ---
  // A chip for displaying selected interests in normal mode
  Widget _buildSelectedChip(BuildContext context, _InterestChipData chipData) {
    return Container(
     
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        
        color: chipData.backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            chipData.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: chipData.foregroundColor,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: chipData.foregroundColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              chipData.count.toString(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // A chip for editing (removable)
  Widget _buildEditableChip(BuildContext context, _InterestChipData chipData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: chipData.backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            chipData.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: chipData.foregroundColor,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedChips.remove(chipData);
                availableChips.add(chipData);
              });
            },
            child: const Icon(Icons.close, size: 16, color: Colors.red),
          ),
        ],
      ),
    );
  }

  // A chip for adding
  Widget _buildAddableChip(BuildContext context, _InterestChipData chipData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: chipData.backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            chipData.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: chipData.foregroundColor,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                availableChips.remove(chipData);
                selectedChips.add(chipData);
              });
            },
            child: const Icon(Icons.add, size: 16, color: Colors.green),
          ),
        ],
      ),
    );
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    return Card(
       color:Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: "Interest Groups" and the edit/done icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Interest Groups",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                // The icon changes based on editing state
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  icon: Icon(
                    _isEditing ? Icons.check : Icons.edit_outlined,
                    color: _isEditing ? Colors.green : const Color(0xFF666666),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Chips are displayed here, changing based on editing state
            if (_isEditing) ...[
              // Display selected chips with a remove icon
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: selectedChips
                    .map((chip) => _buildEditableChip(context, chip))
                    .toList(),
              ),
              const Divider(height: 30),
              // Display available chips with an add icon
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: availableChips
                    .map((chip) => _buildAddableChip(context, chip))
                    .toList(),
              ),
            ] else ...[
              // Display chips normally
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: selectedChips
                    .map((chip) => _buildSelectedChip(context, chip))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// To use this card in your app, you would place `InterestGroupsCard()` in a parent widget's build method.
// Example:
// Scaffold(
//   body: Center(
//     child: InterestGroupsCard(),
//   ),
// )