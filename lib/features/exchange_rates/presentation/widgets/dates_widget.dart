import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/app_button.dart';

class DatesWidget extends StatefulWidget {
  const DatesWidget({super.key});

  @override
  State<DatesWidget> createState() => _DatesWidgetState();
}

class _DatesWidgetState extends State<DatesWidget> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          // Start date
          Expanded(
            child: AppButton(
              placeHolderText: 'Start Date',
              onPressed: () {
                _selectDate(context, _startDateController);
              },
              text: _startDateController.text.isEmpty
                  ? null
                  : 'Start: ${_startDateController.text}',
            ),
          ),
          const SizedBox(width: 8),
          // End date
          Expanded(
            child: AppButton(
              placeHolderText: 'End Date',
              onPressed: () {
                _selectDate(context, _endDateController);
              },
              text: _endDateController.text.isEmpty
                  ? null
                  : 'End: ${_endDateController.text}',
            ),
          ),
        ],
      ),
    );
  }
}
