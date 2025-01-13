import 'package:flutter/material.dart';
import 'package:recipe_app/RazorPay/razorpay_integration.dart';
import 'package:recipe_app/animations/transition_to_anyDirection.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String fullName;
  final String subType;
  final String subTime;

  ProfilePage({
    super.key,
    required this.email,
    required this.fullName,
    required this.subType,
    required this.subTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1520),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0B1520),
        title: const Text(
          ' My Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Add edit functionality
            },
            child: const Text(
              ' Edit  ',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // If the width is larger, we can display things side by side
          bool isLargeScreen = constraints.maxWidth > 600;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ad-Free Promo Section
                _buildAdFreePromoSection(context, isLargeScreen),
                const SizedBox(height: 20),
                // User Info Section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileInfoRow(label: 'Email', value: email),
                      const Divider(color: Colors.white54),
                      ProfileInfoRow(label: 'Full Name', value: fullName),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Subscription Section
                Text(
                  'Subscription',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileInfoRow(label: 'Subscription Type', value: subType),
                      const Divider(color: Colors.white54),
                      ProfileInfoRow(label: 'Subscription Time', value: subTime),
                      const Divider(color: Colors.white54),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.tealAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          // Navigate to subscription management or upgrade
                        },
                        child: Center(
                          child: Text(
                            subType.toLowerCase() == 'free'
                                ? 'Upgrade to Premium'
                                : 'Manage Subscription',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAdFreePromoSection(BuildContext context, bool isLargeScreen) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2730),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.tealAccent.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.star, color: Colors.yellowAccent, size: 24),
              SizedBox(width: 8),
               Text(
                  "Ad-Free Premium Experience!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Upgrade now to enjoy a distraction-free experience and unlock exclusive features!",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.tealAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                VerticalPageRoute(page: RazorpayPaymentScreen(), direction: SlideDirection.fromBottom),
              );
            },
            child: const Center(
              child: Text(
                "Limited Offer - ₹ 5",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({
    super.key,
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
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
