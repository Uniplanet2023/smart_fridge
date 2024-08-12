import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndPoliciesPage extends StatelessWidget {
  const TermsAndPoliciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Policies',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Policies for Smart Fridge App',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            Text(
              'Introduction',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Welcome to Smart Fridge, an AI-powered app that generates personalized recipes based on the items in your fridge. This document outlines the terms and policies governing your use of the Smart Fridge app. By using the app, you agree to comply with these terms.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16.h),
            Text(
              'Privacy Policy',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            _buildSectionTitle(context, 'Data Collection'),
            _buildBulletPoint(context,
                'No Receipt, Fridge Items, or Recipe Data Collection: Smart Fridge does not collect, use, save, or have access to any of the scanned receipts, fridge items, or generated recipes from your device. All such data remains securely stored on your device.'),
            _buildBulletPoint(context,
                'User Information: The only data we collect is basic user information necessary for authentication and account management. This includes your email address, username, and any other information required to create and maintain your account.'),
            _buildBulletPoint(context,
                'Shared Recipes: If you choose to share recipes through the app, we will have access to the shared recipe data only for the purpose of sharing with other users. We do not store or use this data beyond the sharing process.'),
            SizedBox(height: 16.h),
            _buildSectionTitle(context, 'Data Storage'),
            _buildBulletPoint(context,
                'Local Storage: All fridge items, scanned receipts, and generated recipes are stored locally on your device. We do not have access to or store this data on our servers.'),
            _buildBulletPoint(context,
                'User Account Information: Basic user information collected for authentication is stored securely on our servers. We use industry-standard security practices to protect your data.'),
            SizedBox(height: 16.h),
            _buildSectionTitle(context, 'Data Use'),
            _buildBulletPoint(context,
                'Authentication: Your basic user information is used solely for the purpose of authenticating your account and ensuring secure access to the app.'),
            _buildBulletPoint(context,
                'Shared Content: If you choose to share a recipe, we will temporarily access the recipe data to facilitate sharing with other users. This data is not stored permanently on our servers.'),
            SizedBox(height: 16.h),
            _buildSectionTitle(context, 'Data Security'),
            _buildBulletPoint(context,
                'Encryption: We use encryption to protect the data stored on your device and during transmission to our servers.'),
            _buildBulletPoint(context,
                'Security Measures: We implement appropriate technical and organizational measures to safeguard your personal information against unauthorized access, alteration, disclosure, or destruction.'),
            SizedBox(height: 16.h),
            Text(
              'Terms of Use',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            _buildSectionTitle(context, 'User Responsibilities'),
            _buildBulletPoint(context,
                'Account Security: You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.'),
            _buildBulletPoint(context,
                'Prohibited Activities: You agree not to misuse the app, including but not limited to unauthorized access, distribution of harmful content, or any activity that violates the rights of others.'),
            SizedBox(height: 16.h),
            _buildSectionTitle(context, 'Intellectual Property'),
            _buildBulletPoint(context,
                'App Content: All content within the Smart Fridge app, including the AI-generated recipes, is the intellectual property of Smart Fridge. You are granted a limited, non-exclusive license to use the app and its content for personal, non-commercial purposes.'),
            _buildBulletPoint(context,
                'User-Generated Content: By sharing recipes through the app, you grant Smart Fridge a non-exclusive, royalty-free license to use, distribute, and display the shared content for the purpose of sharing with other users.'),
            SizedBox(height: 16.h),
            _buildSectionTitle(context, 'Limitation of Liability'),
            _buildBulletPoint(context,
                'Service Availability: Smart Fridge is provided on an "as is" basis. We do not guarantee the availability, accuracy, or reliability of the app\'s services.'),
            _buildBulletPoint(context,
                'Liability: To the fullest extent permitted by law, Smart Fridge and its affiliates shall not be liable for any damages arising from your use of the app, including but not limited to direct, indirect, incidental, or consequential damages.'),
            SizedBox(height: 16.h),
            Text(
              'Changes to Terms and Policies',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Updates: We may update these terms and policies from time to time. We will notify you of any significant changes through the app or by email. Continued use of the app after any changes constitutes acceptance of the updated terms.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16.h),
            Text(
              'Contact Information',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text:
                    'If you have any questions or concerns regarding these terms and policies, please contact us at ',
                style: Theme.of(context).textTheme.bodyLarge, // Base style
                children: [
                  TextSpan(
                    text: 'uniplanet.info@gmail.com',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary, // Primary color for email
                        ),
                  ),
                  TextSpan(
                    text: '.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Conclusion',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Thank you for using Smart Fridge. We are committed to protecting your privacy and providing a secure, enjoyable experience.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
