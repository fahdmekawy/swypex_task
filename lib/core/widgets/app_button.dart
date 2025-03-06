import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final String placeHolderText;
  final Function()? onPressed;

  const AppButton({
    super.key,
    this.text,
    required this.placeHolderText,
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
      child: FittedBox(
        child: SizedBox(
          child: Text(
            text ?? placeHolderText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
