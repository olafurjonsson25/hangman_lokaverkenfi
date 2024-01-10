import 'package:flutter/material.dart';
import 'package:hangman/settingsScreen.dart';
import 'package:hangman/gamescreen.dart';

void main() {
  runApp(const HangmanGame());
}

class HangmanGame extends StatelessWidget {
  const HangmanGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman Game',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.teal,
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Images/r.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Lets Hang!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 19, horizontal: 82),
                ),
                child: const Text('Play'),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 19, horizontal: 60),
                ),
                child: const Text('Challenges'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
