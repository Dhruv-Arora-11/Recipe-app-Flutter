import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Color customColor = Color(0xFF0B1520);
  final optionalColor = Colors.tealAccent;
  final optionalColor2 = Colors.white;

  final String email;
  final String fullName;
  final String subType;
  final String subTime;

  ProfilePage({
    required this.email,
    required this.fullName,
    required this.subType,
    required this.subTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        backgroundColor: customColor,
        title: Text(
          ' My Profile',
          style: TextStyle(color: optionalColor2),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Add edit functionality
            },
            child: Text(
              ' Edit  ',
              style: TextStyle(color: optionalColor2),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/obito.jpg'), // Replace with user's image
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Add change profile picture functionality
                    },
                    icon: Icon(Icons.camera_alt, color:optionalColor2),
                    label: Text(
                      'Change Profile Picture',
                      style: TextStyle(color: optionalColor2),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileInfoRow(label: 'Email', value: email),
                  Divider(color: Colors.white54),
                  ProfileInfoRow(label: 'Full Name', value: fullName),
                  Divider(color: Colors.white54),
                  ProfileInfoRow(label: 'Subscription Type', value: subType),
                  Divider(color: Colors.white54),
                  ProfileInfoRow(label: 'Subscription Time', value: subTime),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {

  final optionalColor2 = Colors.white;

  final String label;
  final String value;

  ProfileInfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: optionalColor2,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
