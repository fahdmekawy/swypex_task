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
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  Widget _buildDateButton({
    required String placeholder,
    required VoidCallback onPressed,
    required String controllerText,
  }) {
    return Expanded(
      child: AppButton(
        placeHolderText: placeholder,
        onPressed: onPressed,
        text: controllerText.isEmpty ? null : '$placeholder: $controllerText',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          _buildDateButton(
            placeholder: 'Start Date',
            onPressed: () => _selectDate(context, _startDateController),
            controllerText: _startDateController.text,
          ),
          const SizedBox(width: 8),
          _buildDateButton(
            placeholder: 'End Date',
            onPressed: () => _selectDate(context, _endDateController),
            controllerText: _endDateController.text,
          ),
        ],
      ),
    );
  }
}
