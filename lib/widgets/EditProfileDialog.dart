import 'package:flutter/material.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();

  // These should be managed by the state in a real app
  String? _selectedCommunity;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    
      title: const Text("Edit Profile"),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      content: SingleChildScrollView(
        child: Form(
          
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Text("First name"),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: "First name",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
               const SizedBox(height: 16),
               const Text("Last name"),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Last name",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
               const SizedBox(height: 16),
               const Text("Email"),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
             
              const Text("Mobile"),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Mobile",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Community"),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCommunity,
                hint: const Text("Select..."),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: ['Community A', 'Community B', 'Community C']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCommunity = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text("Gender"),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                hint: const Text("Prefer not to say"),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: ['Male', 'Female', 'Prefer not to say'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text("DOB"),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Image"),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Handle choose file
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF0F0F0),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Choose File"),
                  ),
                  const SizedBox(width: 8),
                  const Text("no file selected"),
                ],
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Handle change college
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE3E8FF),
              foregroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Change College"),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Handle sync Discord
            },
            icon: const Icon(Icons.discord, color: Colors.blue), // Placeholder icon
            label: const Text("Sync Discord Image"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE3E8FF),
              foregroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Handle update profile
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Update Profile"),
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
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(color: Colors.grey),
            ),
            child: const Text("Close"),
          ),
        ),
      ],
    );
  }
}