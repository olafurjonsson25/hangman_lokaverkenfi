import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final List<String> keys = [
    'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P',
    'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L',
    'Z', 'X', 'C', 'V', 'B', 'N', 'M'
  ];
  final Function(String) onKeyPressed;

  Keyboard({required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 2.0,
        runSpacing: 2.0,
        children: keys.map((String key) {
          return ElevatedButton(
            onPressed: () {
              onKeyPressed(key);
            },
            child: Text(key),
          );
        }).toList(),
      ),
    );
  }
}