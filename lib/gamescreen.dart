import 'package:flutter/material.dart';
import 'dart:math';
import 'keyboard.dart';

// Class representing boxes to display letters of a selected word
class WordBoxes extends StatelessWidget {
  final List<String> normalWords = [
    'apple',
    'banana',
    'orange',
    'grape',
    'pepsi',
    'keyboard',
    'screen'
  ];
  late String selectedWord;
// Constructor to initialize a WordBoxes instance with a randomly chosen word
  WordBoxes({Key? key}) : super(key: key) {
    selectedWord = normalWords[Random().nextInt(normalWords.length)];
  }
// Method to build boxes representing each letter of the selected word
  List<Widget> buildLetterBoxes() {
    List<Widget> letterBoxes = [];
    for (int i = 0; i < selectedWord.length; i++) {
      letterBoxes.add(
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            '_',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    }
    return letterBoxes;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buildLetterBoxes(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}
// State class associated with the GameScreen widget
class _GameScreenState extends State<GameScreen> {
  int incorrectGuesses = 0;
  late String selectedWord;
  late List<bool> guessedLetters;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }
  // Function to initialize the game
  void initializeGame() {
    selectedWord = WordBoxes().selectedWord;
    guessedLetters = List.filled(selectedWord.length, false);
  }

  void handleIncorrectGuess() {
    setState(() {
      incorrectGuesses++;
    });
  }
// Function to check if the guessed letter is present in the selected word
  void checkLetter(String key) {
    setState(() {
      bool found = false;
      for (int i = 0; i < selectedWord.length; i++) {
        if (selectedWord[i] == key.toLowerCase()) {
          guessedLetters[i] = true;
          found = true;
        }
      }
      if (!found) {
        handleIncorrectGuess();
      }
    });
  }
//funcion to check if game is still going win/loss/how many tries left
  void checkGameState() {
    if (!guessedLetters.contains(false)) {
      showGameOverDialog(true);
    } else if (incorrectGuesses >= 6) {
      showGameOverDialog(false);
    }
  }
  // victory or loser screen
  void showGameOverDialog(bool isVictory) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isVictory ? 'Congratulations!' : 'Game Over'),
          content: Text(isVictory
              ? 'You guessed the word!'
              : 'You ran out of attempts. The word was: $selectedWord.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  initializeGame();
                  incorrectGuesses = 0;
                });
              },
            ),
          ],
        );
      },
    );
  }
// ui for the gamescreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'Images/r.png',//background image
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomPaint(
                size: const Size(200, 200),
                painter: HangmanPainter(incorrectGuesses),// Custom paint for hangman visualization
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < selectedWord.length; i++)
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        guessedLetters[i] ? selectedWord[i] : '_',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Keyboard(
                onKeyPressed: (String key) {
                  print('Pressed key: $key');
                  if (!guessedLetters.contains(false)) {
                    print('Congratulations! You guessed the word.');
                  } else {
                    if (guessedLetters.contains(key.toLowerCase())) {
                      print('Already guessed this letter.');
                    } else {
                      checkLetter(key);
                      checkGameState();
                    }
                  }
                },
              ),
            ],
          ),
          Positioned(
            top: 70,
            right: 107,
            child: Image.asset(
              'Images/pole.png', // Positioned image for the hangman pole
              width: 260,
              height: 260,
            ),
          ),
        ],
      ),
    );
  }
}
// CustomPainter class to draw hangman elements based on incorrect guesses
class HangmanPainter extends CustomPainter {
  final int incorrectGuesses;

  HangmanPainter(this.incorrectGuesses);

  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    // Drawing hangman elements based on the count of incorrect guesses
    if (incorrectGuesses >= 1) {
      canvas.drawCircle(Offset(size.width / 2, 50.0), 20.0, paint);
    }
    if (incorrectGuesses >= 2) {
      canvas.drawLine(
        Offset(size.width / 2, 70.0),
        Offset(size.width / 2, 130.0),
        paint,
      );
    }
    if (incorrectGuesses >= 3) {
      canvas.drawLine(
        Offset(size.width / 2, 80.0),
        Offset(size.width / 3, 110.0),
        paint,
      );
    }
    if (incorrectGuesses >= 4) {
      canvas.drawLine(
        Offset(size.width / 2, 80.0),
        Offset((2 * size.width) / 3, 110.0),
        paint,
      );
    }
    if (incorrectGuesses >= 5) {
      canvas.drawLine(
        Offset(size.width / 2, 130.0),
        Offset(size.width / 3, 180.0),
        paint,
      );
    }
    if (incorrectGuesses >= 6) {
      canvas.drawLine(
        Offset(size.width / 2, 130.0),
        Offset((2 * size.width) / 3, 180.0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint when changes occur
  }
}
