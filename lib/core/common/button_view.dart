import 'package:flutter/material.dart';

class ButtonsView extends StatelessWidget {
  final String buttonText;
  final Function buttonTapped;

  const ButtonsView({
    super.key,
    required this.buttonText,
    required this.buttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        buttonTapped();
      },
      borderRadius: BorderRadius.circular(10.0),
      child: Card(
        color: Colors.amber[300],
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              fontFamily: 'OpenSans Bold',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ), // Optional: Set border radius
    );
  }
}