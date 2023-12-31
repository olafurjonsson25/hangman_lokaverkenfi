import 'package:flutter/material.dart';
import 'package:hangman/keyboard.dart';
import 'package:hangman/words.dart';
class Words extends StatelessWidget {
  final word = normalWords;

  Words({super.key});

  List<Widget> buildLetterBoxes() {
    List<Widget> letterBoxes = [];
    for (int i = 0; i < normalWords.length; i++) {
      letterBoxes.add(
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
    }
    return letterBoxes;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}



class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

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
class HangmanPainter extends CustomPainter {
  final int incorrectGuesses;

  HangmanPainter(this.incorrectGuesses);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    if (incorrectGuesses >= 1) {
      // Draw head
      canvas.drawCircle(Offset(size.width / 2, 40.0), 20.0, paint);
    }
    if (incorrectGuesses >= 2) {
      // Draw body
      canvas.drawLine(
        Offset(size.width / 2, 60.0),
        Offset(size.width / 2, 120.0),
        paint,
      );
    }
    if (incorrectGuesses >= 3) {
      // Draw left arm
      canvas.drawLine(
        Offset(size.width / 2, 70.0),
        Offset(size.width / 3, 100.0),
        paint,
      );
    }
    if (incorrectGuesses >= 4) {
      // Draw right arm
      canvas.drawLine(
        Offset(size.width / 2, 70.0),
        Offset((2 * size.width) / 3, 100.0),
        paint,
      );
    }
    if (incorrectGuesses >= 5) {
      // Draw left leg
      canvas.drawLine(
        Offset(size.width / 2, 120.0),
        Offset(size.width / 3, 170.0),
        paint,
      );
    }
    if (incorrectGuesses >= 6) {
      // Draw right leg
      canvas.drawLine(
        Offset(size.width / 2, 120.0),
        Offset((2 * size.width) / 3, 170.0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}




