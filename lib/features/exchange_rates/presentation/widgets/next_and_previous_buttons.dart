import 'package:flutter/material.dart';
import 'package:swypex_task/core/widgets/app_button.dart';

class NextAndPreviousButtons extends StatelessWidget {
  final Function() onNext;
  final Function() onPrevious;

  const NextAndPreviousButtons({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            placeholderText: '<',
            onPressed: onPrevious,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(
            placeholderText: '>',
            onPressed: onNext,
          ),
        ),
      ],
    );
  }
}
