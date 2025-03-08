import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final String placeholderText;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    this.text,
    required this.placeholderText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 5,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: Text(
        text ?? placeholderText,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
