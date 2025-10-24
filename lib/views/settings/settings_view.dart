import 'package:flutter/material.dart';
import 'widgets/settings_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: const [
            SingleChildScrollView(
              child: Column(
                children: [
                  SettingsTile(title: 'Language'),
                  SettingsTile(title: 'Change Password'),
                  SettingsTile(title: 'Contact Support'),
                  SettingsTile(title: 'Submit a Complaint'),
                  SettingsTile(title: 'Privacy Policy'),
                  SettingsTile(title: 'Terms of Service'),
                  SettingsTile(title: 'Delete Account', destructive: true),
                  SettingsTile(title: 'Logout', destructive: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
