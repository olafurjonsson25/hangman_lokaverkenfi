import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman Game - Settings'),
      ),
      // Add your settings interface here
      body: const Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}