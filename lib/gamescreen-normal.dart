import 'package:flutter/material.dart';
import 'package:hangman/keyboard.dart';

class GameScreenNormal extends StatelessWidget {
  const GameScreenNormal ({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Images/r.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Container(),
            ),
            Keyboard(
              onKeyPressed: (String key) {
                print('Pressed key: $key');
              },
            ),

          ],
        ),
      ),
    );
  }
}
