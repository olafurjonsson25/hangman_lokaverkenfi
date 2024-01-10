import 'package:flutter/material.dart';
import 'dart:math';
import 'keyboard.dart';

class WordBoxes extends StatelessWidget {
  final List<String> normalWords = [
    'key',
    'hat',
    'shoe',
    'ball',
    'lamp',
    'chair',
    'table',
  ];
  late String selectedWord;

  WordBoxes({Key? key}) : super(key: key) {
    selectedWord = normalWords[Random().nextInt(normalWords.length)];
  }

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

class gameScreenEasy extends StatefulWidget {
  const gameScreenEasy({Key? key}) : super(key: key);

  @override
  _gameScreenEasy createState() => _gameScreenEasy();
}

class _gameScreenEasy extends State<gameScreenEasy> {
  int incorrectGuesses = 0;
  late String selectedWord;
  late List<bool> guessedLetters;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    selectedWord = WordBoxes().selectedWord;
    guessedLetters = List.filled(selectedWord.length, false);
  }

  void handleIncorrectGuess() {
    setState(() {
      incorrectGuesses++;
    });
  }

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

  void checkGameState() {
    if (!guessedLetters.contains(false)) {
      showGameOverDialog(true);
    } else if (incorrectGuesses >= 6) {
      showGameOverDialog(false);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'Images/r.png',
            fit: BoxFit.cover,
          ),
          // Other widgets on top of the background
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomPaint(
                size: const Size(200, 200),
                painter: HangmanPainter(incorrectGuesses),
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
              'Images/pole.png', // Replace with your image path
              width: 260,
              height: 260,
            ),
          ),
        ],
      ),
    );
  }
}

class HangmanPainter extends CustomPainter {
  final int incorrectGuesses;

  HangmanPainter(this.incorrectGuesses);

  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

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
    return true;
  }
}
