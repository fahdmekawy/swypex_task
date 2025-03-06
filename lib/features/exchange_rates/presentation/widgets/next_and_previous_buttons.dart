import 'package:flutter/material.dart';
import 'package:swypex_task/core/widgets/app_button.dart';

class NextAndPreviousButtons extends StatelessWidget {
  const NextAndPreviousButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            placeHolderText: '<',
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(
            placeHolderText: '>',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
