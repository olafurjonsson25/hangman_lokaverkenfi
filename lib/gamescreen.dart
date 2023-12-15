import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman Game - Play'),
      ),
      // Add your game interface here
      body: const Center(
        child: Text('Game Screen'),
      ),
    );
  }
}